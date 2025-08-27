import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/api/map_api.dart';
import 'package:mime/mime.dart';
import 'package:sba/src/services/file_service.dart';
import 'package:sba/src/utils/uuid.dart';
import '../states/map_state.dart';

class MapController extends BaseController<MapState> {
  MapController(MapState state, Ref ref) : super(state, ref);

  GoogleMapController? controller;
  String sessionToken = Uuid().generateV4();

  static final mapControllerProvider = StateNotifierProvider.autoDispose
      .family<MapController, MapState, MapPageData>((ref, args) {
    return MapController(
        MapState(
          center: args.center,
          id: args.proposalCode,
          appraisalFileId: args.appraisalFileId,
        ),
        ref);
  });

  TextEditingController searchController = TextEditingController();

  Future<String> getLocationName(String latLng, String sessionToken) async {
    return ref.read(mapApiProvider).getLocationName(latLng, sessionToken);
  }

  Future getSuggestion(String input) async {
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
      final response = LatLng(lat, lng);
      updateMarkerFromPosition(response);
      initMarker(response, locationName: result);
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

  Future getDetailFromPlaceId(placeId) async {
    LatLng? result = await ref
        .read(mapApiProvider)
        .getDetailFromPlaceId(placeId, sessionToken);
    if (result != null) {
      state = state.copyWith.call(listItem: []);
    }
    return result;
  }

  void saveMapLocation(BuildContext context) async {
    if (isShowLoading) return;
    if (state.marker == null) {
      showMessageDialog(S.current.vui_long_chon_vi_tri_tai_san);
      return;
    }
    showLoading();

    ref.read(assetsApiProvider).updateLocation(
          appraisalFileId: state.appraisalFileId ?? '',
          lat: state.marker?.position.latitude,
          lng: state.marker?.position.longitude,
        );

    var snapShot = await controller?.takeSnapshot();
    if (snapShot == null) return;

    // hideLoading();

    var mime = lookupMimeType('', headerBytes: snapShot);
    var extension = extensionFromMime(mime ?? '');

    final result = Attachment(
      mediaType: mime,
      fileSize: snapShot.length,
      file: AttachmentFile(
        size: snapShot.length,
        bytes: snapShot,
        name: 'map_image_${DateTime.now().millisecondsSinceEpoch}.png',
      ),
    );

    try {
      final uploadResult = await ref.read(fileServiceProvider).sendImage(
            result.file,
            code: state.id,
          );
      hideLoading();

      if (!mounted) return;

      if (uploadResult != null) {
        Navigator.of(context).maybePop(uploadResult);
      } else {
        showMessageDialog(S.current.upload_anh_dinh_vi_loi);
      }
    } catch (e) {
      hideLoading();
      showMessageDialog(S.current.upload_anh_dinh_vi_loi);
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    this.controller = controller;
  }

  void initMarker(LatLng position, {String? locationName}) async {
    Marker mainMarker = Marker(
      markerId: const MarkerId('mainMarker'),
      draggable: true,
      position: position,
      infoWindow: const InfoWindow(
        title: 'Địa chỉ tài sản',
        // snippet: state.detail.fullAddress,
      ),
      onDragEnd: (position) {
        state = state.copyWith(center: position);
      },
      icon: BitmapDescriptor.defaultMarker,
    );
    state = state.copyWith(marker: mainMarker);

    final detail = locationName ??
        await getLocationName(
            '${position.latitude},${position.longitude}', sessionToken);
    final splitString = detail.split(',');
    var result = '';
    for (var i = 0; i < splitString.length; i++) {
      result += '${splitString[i]}, ';
      if (i % 2 == 0) {
        result += '\n';
      }
    }
    mainMarker = mainMarker.copyWith(
      infoWindowParam: InfoWindow(
        title: 'Địa chỉ tài sản',
        snippet: detail,
      ),
    );
    state = state.copyWith(marker: mainMarker);
    controller?.showMarkerInfoWindow(mainMarker.markerId);
  }

  void updateCameraPosition(CameraPosition newPosition) async {
    // final bounce = await controller?.getVisibleRegion();
    // final marker = state.marker;
    // if (marker == null) return;
    // if (bounce?.contains(marker.position) == false) {
    //   updateMarkerFromPosition(marker.position);
    // }
  }

  void updateMarkerFromPosition(LatLng newPosition) {
    final marker = state.marker;
    state = state.copyWith.call(
      marker: marker?.copyWith(
        positionParam: newPosition,
        infoWindowParam:
            marker.infoWindow.copyWith(titleParam: searchController.text),
      ),
      center: newPosition,
    );
    controller?.moveCamera(CameraUpdate.newLatLng(newPosition));
  }

  void setNewLocation(LatLng response) {
    updateMarkerFromPosition(response);
    initMarker(response, locationName: searchController.text);
  }

  void updateAddressText(item) {
    searchController.text = item;
  }

  void onMapTapped(LatLng position) {
    initMarker(position);
  }
}
