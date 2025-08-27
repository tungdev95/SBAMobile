// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/assets/assets.dart';

abstract class BaseDetailModel {
  @JsonKey(defaultValue: '')
  String assetId;
  @JsonKey(defaultValue: '')
  String assetCode;
  String? whoCreate;
  String? rmName;
  String? rmPhone;
  DateTime? dateCreate;
  DateTime? dateModify;
  DateTime? surveyTime;

  /// Lợi thế kinh doanh
  String? businessAdvantage;

  /// Tính thanh khoản
  String? liquidity;

  /// Hiện trạng sử dụng
  String? currentUseSituation;

  /// Thông tin quy hoạch;
  String? disputeInfor;

  ///Ghi chú
  String? note;

  String? planningInfor;

  @JsonKey(toJson: riskDetailToJson, defaultValue: [])
  List<RiskFactorModel> riskDetails;

  @JsonKey(
      toJson: legalInformationsToJson,
      fromJson: legalInformationsFromJson,
      defaultValue: [])
  List<LegalModel> legalInformations;

  int get exportType;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool xuatThongTinTomTat;

  Map<String, Object?>? extraData;

  BaseDetailModel({
    required this.assetId,
    required this.assetCode,
    this.whoCreate,
    this.dateCreate,
    this.dateModify,
    required this.riskDetails,
    required this.legalInformations,
    this.businessAdvantage,
    this.liquidity,
    this.currentUseSituation,
    this.disputeInfor,
    this.note,
    this.planningInfor,
    this.xuatThongTinTomTat = false,
    this.rmName,
    this.rmPhone,
    this.surveyTime,
    this.extraData,
  });
}

List<Map<String, dynamic>> riskDetailToJson(List<RiskFactorModel> lsItem) {
  lsItem.removeWhere((element) {
    return element.riskTypeId == null;
  });
  final result = lsItem.map((e) => e.toJson()).toList();

  return result;
}

List<Map<String, dynamic>> legalInformationsToJson(List<LegalModel> lsItem) {
  return lsItem.mapIndexed((index, e) {
    e.orderBy = index;
    return e.toJson();
  }).toList();
}

List<LegalModel> legalInformationsFromJson(List<dynamic>? lsItem) {
  return (lsItem ?? []).mapIndexed((index, e) {
    return LegalModel.fromJson(e);
  }).toList()
    ..sort((a, b) => (a.orderBy ?? 0).compareTo(b.orderBy ?? 0));
}
