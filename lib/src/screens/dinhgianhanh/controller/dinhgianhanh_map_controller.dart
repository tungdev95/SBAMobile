import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_map_state.dart';
import 'package:sba/src/services/api/map_api.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/map_widget.dart';

class DinhGiaNhanhMapController extends BaseController<DinhGiaNhanhMapState> {
  DinhGiaNhanhMapController(DinhGiaNhanhMapState state, Ref ref)
      : super(state, ref);

  static final mapControllerProvider = StateNotifierProvider.autoDispose.family<
      DinhGiaNhanhMapController,
      DinhGiaNhanhMapState,
      FastValuationModel>((ref, params) {
    final mapState = DinhGiaNhanhMapState(
      detail: params,
      center: LatLng(
        params.latitude ?? lastKnowPosition?.latitude ?? 0.0,
        params.longitude ?? lastKnowPosition?.longitude ?? 0.0,
      ),
      listItem: [],
      listMarker: [],
    );
    final controller = DinhGiaNhanhMapController(mapState, ref);
    controller.searchController.text = params.fullAddress;
    return controller;
  });

  TextEditingController searchController = TextEditingController();
  GlobalKey<MapWidgetState> mapState = GlobalKey();
  GoogleMapController? controller;

  @override
  Future<void> initialLoad() async {}

  void initMarker() {
    final lsMarker = <Marker>[];
    Marker mainMarker = Marker(
      markerId: const MarkerId('mainMarker'),
      position: LatLng(
        state.center.latitude,
        state.center.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Địa chỉ tài sản',
        snippet: state.detail.fullAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    lsMarker.add(mainMarker);

    for (var element in state.detail.valuations) {
      final title = 'TSSS ${state.detail.valuations.indexOf(element) + 1}';
      Marker tsss = Marker(
        markerId: MarkerId('TSSS$title'),
        position: LatLng(
          element.latitude ?? 0.0,
          element.longitude ?? 0.0,
        ),
        infoWindow: InfoWindow(
          title: title,
          snippet: element.fullAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      lsMarker.add(tsss);
    }
    state = state.copyWith(listMarker: lsMarker);
  }

  void onMapCreated(GoogleMapController controller) async {
    this.controller = controller;
    initMarker();
    if (state.detail.radius != 0) {
      final circle = Circle(
        circleId: const CircleId('center'),
        center: state.center,
        fillColor: Colors.blue.shade50,
        strokeColor: Colors.blue,
        strokeWidth: 1,
        radius: (state.detail.radius ?? 0.0) * 1000,
      );
      state = state.copyWith(circle: {circle});
    }

    await Future.delayed(const Duration(seconds: 1));

    // for (var element in state.listMarker) {
    //   await controller.showMarkerInfoWindow(element.markerId);
    // }

    final bounce = await controller.getVisibleRegion();
    double zoom = 16.0;
    LatLngBounds screenBounds;

    final LatLngBounds markerBounds = bounce;

    do {
      await controller.moveCamera(CameraUpdate.newLatLngZoom(
        state.center,
        zoom,
      ));

      screenBounds = await controller.getVisibleRegion();

      zoom -= .5;
    } while (!screenBounds.contains(markerBounds.northeast) ||
        !screenBounds.contains(markerBounds.southwest));

    controller.moveCamera(
      CameraUpdate.newLatLngZoom(
        computecentroid(
          state.listMarker.map((e) => e.position).toList(),
        ),
        zoom,
      ),
    );
  }

  LatLng computecentroid(List<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (var point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  Future<String> getLocationDetail(String latLng, String sessionToken) async {
    return ref.read(mapApiProvider).getLocationCityName(latLng, sessionToken);
  }

  Future getSuggestion(String input, sessionToken) async {
    bool isCoordinate = _isCoordinate(input);
    if (isCoordinate) {
      var result =
          await ref.read(mapApiProvider).getLocationName(input, sessionToken);
      var fakeItem = {
        'description': result,
        'place_id': '',
      };
      final lat = double.parse(input.split(',')[0].trim());
      final lng = double.parse(input.split(',')[1].trim());
      focusItemLatLng(LatLng(lat, lng), result);
    } else {
      var result =
          await ref.read(mapApiProvider).getSuggestion(input, sessionToken);
      state = state.copyWith.call(listItem: result);
    }
  }

  // Kiểm tra xem chuỗi nhập vào có phải tọa độ không
  bool _isCoordinate(String input) {
    final regex = RegExp(r'^-?\d+(\.\d+)?,-?\d+(\.\d+)?$');
    return regex.hasMatch(input.trim());
  }

  Future getDetailFromPlaceId(placeId, sessionToken, desc) async {
    LatLng? result = await ref
        .read(mapApiProvider)
        .getDetailFromPlaceId(placeId, sessionToken);
    focusItemLatLng(result, desc);
    return result;
  }

  void focusItemLatLng(LatLng? result, String? desc) async {
    if (result != null) {
      final mainMarkerIndex = state.listMarker
          .indexWhere((element) => element.markerId.value == 'mainMarker');

      Marker mainMarker = state.listMarker[mainMarkerIndex].copyWith(
        infoWindowParam: InfoWindow(
          title: 'Địa chỉ tài sản',
          snippet: desc,
        ),
        positionParam: result,
      );

      await controller?.moveCamera(CameraUpdate.newLatLngZoom(
        result,
        16.0,
      ));
      state = state.copyWith.call(
        center: result,
        listItem: [],
        listMarker: state.listMarker..[mainMarkerIndex] = mainMarker,
      );
    }
  }

  void saveMapLocation(
    BuildContext context,
  ) async {
    // showLoading();
    // var snapShot = await mapState.currentState?.takeMapSnapShot();
    // if (snapShot == null) return;
    // hideLoading();

    // var mime = lookupMimeType('', headerBytes: snapShot);
    // var extension = extensionFromMime(mime ?? '');

    // final result = Attachment(
    //   mediaType: mime,
    //   fileSize: snapShot.length,
    //   file: AttachmentFile(
    //     size: snapShot.length,
    //     bytes: snapShot,
    //     name: 'map_image_${DateTime.now().millisecondsSinceEpoch}.png',
    //   ),
    // );
    Navigator.of(context).maybePop(state.center);
  }

  void onMapTapped(LatLng position) async {
    final mainMarkerIndex = state.listMarker
        .indexWhere((element) => element.markerId.value == 'mainMarker');

    Marker mainMarker = state.listMarker[mainMarkerIndex].copyWith(
      infoWindowParam: const InfoWindow(
        title: '',
        snippet: '',
      ),
      positionParam: position,
    );

    await controller?.moveCamera(CameraUpdate.newLatLngZoom(
      position,
      16.0,
    ));
    state = state.copyWith.call(
      center: position,
      listMarker: state.listMarker..[mainMarkerIndex] = mainMarker,
    );
  }
}
