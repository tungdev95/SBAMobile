import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'survey_detail_model.g.dart';

@JsonSerializable(includeIfNull: true)
class SurveyDetailData {
  String? startAddress;
  String? desAddress;
  @JsonKey(fromJson: _localLatLngFromJson, includeIfNull: true)
  LocalLatLng? startLocation;
  @JsonKey(fromJson: _localLatLngFromJson, includeIfNull: true)
  LocalLatLng? desLocation;
  double? distance;
  bool? begin;
  //   // List<LocalLatLng>? listPoint = [];
  String? minutesId;
  String? imageId;
  bool? isFinish;
  String? doanDuong;

  SurveyDetailData({
    this.startAddress,
    this.desAddress,
    this.startLocation,
    this.desLocation,
    this.distance,
    this.begin = false,
    // this.listPoint,
    this.minutesId,
    this.imageId,
    this.isFinish,
    this.doanDuong,
  });

  static LocalLatLng? _localLatLngFromJson(Map<String, dynamic>? json) =>
      json == null ? null : LocalLatLng.fromJson(json);

  factory SurveyDetailData.fromJson(dynamic json) =>
      _$SurveyDetailDataFromJson(json);
  Map<String, dynamic>? toJson() => _$SurveyDetailDataToJson(this);
}

@JsonSerializable(includeIfNull: true)
class LocalLatLng {
  String? latitude;
  String? longitude;

  LatLng getLatLng() {
    return LatLng(double.tryParse(latitude ?? '0.0') ?? 0.0,
        double.tryParse(longitude ?? '0.0') ?? 0.0);
  }

  LocalLatLng(
    this.latitude,
    this.longitude,
  );

  factory LocalLatLng.fromJson(dynamic json) => _$LocalLatLngFromJson(json);
  Map<String, dynamic>? toJson() => _$LocalLatLngToJson(this);
}
