import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/maps/survey_detail_model.dart';
part 'survey_end_model.g.dart';

@JsonSerializable()
class SurveyEndModel {
  String? minutesId;
  String? userName;
  String? imageId;
  LocalLatLng? endLocation;
  double? difference;
  String? endAddress;
  double? endDistance;
  SurveyEndModel({
    this.minutesId,
    this.userName,
    this.imageId,
    this.endLocation,
    this.difference,
    this.endAddress,
    this.endDistance,
  });
  factory SurveyEndModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyEndModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyEndModelToJson(this);
}
