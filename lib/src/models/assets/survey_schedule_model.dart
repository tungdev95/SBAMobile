// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/base/serializer.dart';
import 'package:sba/src/utils/uuid.dart';

part 'survey_schedule_model.g.dart';

@JsonSerializable()
class SurveyScheduleModel {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;
  int? surveyScheduleId;
  String? appraisalFileId;
  DateTime? timeStart;
  DateTime? timeEnd;
  String? note;
  String? whoCreate;
  bool? isMetCustomer;

  /// Map of custom channel extraData
  Map<String, Object?> extraData;

  SurveyScheduleModel({
    this.id,
    this.surveyScheduleId,
    this.appraisalFileId,
    this.timeStart,
    this.timeEnd,
    this.note,
    this.whoCreate,
    this.isMetCustomer,
    this.extraData = const {},
  }) {
    id ??= Uuid().generateV4();
  }

  factory SurveyScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyScheduleModelFromJson(
          Serializer.moveToExtraDataFromRoot(json, topLevelFields));

  Map<String, dynamic> toJson() =>
      Serializer.moveFromExtraDataToRoot(_$SurveyScheduleModelToJson(this));

  static const topLevelFields = [
    'surveyScheduleId',
    'appraisalFileId',
    'timeStart',
    'timeEnd',
    'note',
    'whoCreate',
    'isMetCustomer',
  ];
}
