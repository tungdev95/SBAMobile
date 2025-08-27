// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sba/src/models/assets/fast_valuation_model.dart';

class DinhGiaNhanhMapState {
  FastValuationModel detail;
  LatLng center;
  List<dynamic> listItem;
  List<Marker> listMarker;
  Set<Circle>? circle;
  DinhGiaNhanhMapState({
    required this.center,
    required this.detail,
    required this.listItem,
    required this.listMarker,
    this.circle,
  });

  DinhGiaNhanhMapState copyWith({
    FastValuationModel? detail,
    LatLng? center,
    List<dynamic>? listItem,
    List<Marker>? listMarker,
    Set<Circle>? circle,
  }) {
    return DinhGiaNhanhMapState(
      detail: detail ?? this.detail,
      center: center ?? this.center,
      listItem: listItem ?? this.listItem,
      listMarker: listMarker ?? this.listMarker,
      circle: circle ?? this.circle,
    );
  }
}
