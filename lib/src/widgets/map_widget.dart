import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/animated_pin.dart';

// ignore: must_be_immutable
class MapWidget extends StatefulWidget {
  LatLng? defaultLatLng;

  @override
  MapWidgetState createState() => MapWidgetState();

  MapWidget({Key? key, this.defaultLatLng}) : super(key: key);
}

class MapWidgetState extends State<MapWidget> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(21.028511, 105.804817),
    zoom: 11.0,
  );
  CameraPosition _position = _kInitialPosition;
  LatLng center = const LatLng(21.028511, 105.804817);

  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  var geolocator = Geolocator();

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    if (widget.defaultLatLng == null) {
      getUserLocation();
    } else {
      setNewLocation(widget.defaultLatLng!);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.defaultLatLng != null) {
      _position = CameraPosition(
        target: widget.defaultLatLng!,
        zoom: 11.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          padding: EdgeInsets.only(
            bottom: context.padding.bottom,
            top: kToolbarHeight + context.padding.top + 16,
          ),
          initialCameraPosition: _position,
          markers: Set<Marker>.of(markers.values),
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          // indoorViewEnabled: true,
          mapToolbarEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: _updateCameraPosition,
          gestureRecognizers: {}
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()),
            ),
        ),
      ],
    );
  }

  Widget _defaultPinBuilder(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedPin(
                  child: Icon(Icons.place, size: 36, color: Colors.red)),
              SizedBox(height: 42),
            ],
          ),
        ),
        Center(
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Future<LatLng?> getUserLocation() async {
    try {
      final location = await LocationUtils.determinePosition();
      final lat = location?.latitude;
      final lng = location?.longitude;
      final value = LatLng(lat ?? 0.0, lng ?? 0.0);
      setNewLocation(value);
      return value;
    } on Exception {
      // currentLocation = null;
      return null;
    }
  }

  void setNewLocation(LatLng value) {
    center = value;
    controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: 18)));
  }

  Future<Uint8List?> takeMapSnapShot() async {
    await _add();
    return await controller?.takeSnapshot();
  }

  LatLng getMapLatLng() => center;

  Future _add() async {
    const String markerIdVal = '1';
    // _markerIdCounter++;
    const MarkerId markerId = MarkerId(markerIdVal);
    selectedMarker = markerId;
    final Marker marker = Marker(
      markerId: markerId,
      draggable: true,
      position: LatLng(
          center.latitude, // + sin(_markerIdCounter * pi / 6.0) / 20.0,
          center.longitude // + cos(_markerIdCounter * pi / 6.0) / 20.0,
          ),
      visible: true,
      infoWindow: const InfoWindow(title: markerIdVal, snippet: '*'),
    );
    marker.onTap?.call();

    setState(() {
      markers[markerId] = marker;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    return WidgetsBinding.instance.endOfFrame;
  }

  void _updateCameraPosition(CameraPosition position) {
    if (mounted) {
      setState(() {
        _position = position;
        center = position.target;
      });
    }
    // _add();
  }
}
