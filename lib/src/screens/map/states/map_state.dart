// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.freezed.dart';

@freezed
class MapState extends Equatable with _$MapState {
  const MapState._(); // Added constructor
  const factory MapState({
    @Default([]) List<dynamic> listItem,
    Marker? marker,
    String? id,
    String? appraisalFileId,
    LatLng? center,
  }) = _MapState;

  @override
  List<Object?> get props => [id];
}

class MapPageData extends Equatable {
  LatLng? center;
  String? proposalCode;
  String? appraisalFileId;

  MapPageData({
    this.center,
    this.proposalCode,
    this.appraisalFileId,
  });

  @override
  List<Object?> get props => [proposalCode];
}
