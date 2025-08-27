// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/base/serializer.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'assets.dart';

part 'real_estate_model.g.dart';

@JsonSerializable()
class RealEstateModel extends BaseDetailModel {
  /// Tổng diện tích mặt tiền
  double? facadeLength;

  /// Kích thước chiều dài
  double? totalLength;

  /// Diện tích sử dụng riêng
  double? combinePrivateArea;

  ///  Diện tích sử dụng chung
  double? combineCommonArea;

  /// Diện tích khuôn viên
  double? combineAreaWidth;

  /// Diện tích phù hợp quy hoạch
  double? combineAreaInPlan;

  /// Diện tích không phù hợp quy hoạch
  double? combineAreaUnPlan;

  /// Ghi chú hợp thửa
  String? combineNote;

  String? combineAppraisalLocation;

  ///Mô tả hình dáng
  String? combineLandShape;

  ///Diện tích mở đường/Diện tích ko xem xét gt
  double? combineAreaNotConsiderValue;

  /// Chi tiết kích thước mặt tiền
  String? combineAreaWidthDetail;

  @JsonKey(defaultValue: [])
  List<AssetLandInfo> assetLandInfors;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool customKichThuocMatTien = false;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool customKichThuocChieuDai = false;

  double get dienTichKhuonVien {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  element.assetLandUsingPurposes.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue + (element.realAreaWidth ?? 0.0),
                  ),
            )
            .format3Number() ??
        0.0;
  }

  double get dienTichPhuHopQuyHoach {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  element.assetLandUsingPurposes.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue + (element.realAreaInPlan ?? 0.0),
                  ),
            )
            .format3Number() ??
        0.0;
  }

  double get dienTichSDRieng {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.realPrivateArea ?? 0.0),
            )
            .format3Number() ??
        0.0;
  }

  double get dienTichSDChung {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.realCommonArea ?? 0.0),
            )
            .format3Number() ??
        0.0;
  }

  double get dienTichKoPhuHopQuyHoach {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  element.assetLandUsingPurposes.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue + (element.realAreaUnPlan ?? 0.0),
                  ),
            )
            .format3Number() ??
        0.0;
  }

  double get dienTichMoDuong {
    return assetLandInfors
            .fold(
              0.0,
              (previousValue, element) =>
                  previousValue +
                  element.assetLandUsingPurposes.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue +
                        (element.realAreaNotConsiderValue ?? 0.0),
                  ),
            )
            .format3Number() ??
        0.0;
  }

  String? combineLandAddressDetail;

  RealEstateModel({
    this.facadeLength,
    this.totalLength,
    this.combinePrivateArea,
    this.combineCommonArea,
    this.combineAreaWidth,
    this.combineAreaInPlan,
    this.combineAreaUnPlan,
    this.combineNote,
    this.combineAppraisalLocation,
    super.businessAdvantage,
    super.liquidity,
    super.currentUseSituation,
    super.disputeInfor,
    super.note,
    super.planningInfor,
    required super.legalInformations,
    required this.assetLandInfors,
    required super.riskDetails,
    required super.assetId,
    required super.assetCode,
    super.whoCreate,
    super.dateCreate,
    super.dateModify,
    super.xuatThongTinTomTat,
    super.rmName,
    super.rmPhone,
    super.surveyTime,
    this.combineLandShape,
    this.combineAreaNotConsiderValue,
    this.combineLandAddressDetail,
    this.combineAreaWidthDetail,
  }) {
    planningInfor ??= 'Không';
    liquidity ??= '2';
    disputeInfor ??= 'Không tranh chấp.';
  }

  factory RealEstateModel.fromJson(dynamic json) => _$RealEstateModelFromJson(
      Serializer.moveToExtraDataFromRoot(json, topLevelFields));

  Map<String, dynamic> toJson() {
    final data =
        Serializer.moveFromExtraDataToRoot(_$RealEstateModelToJson(this));
    assetLandInfors.forEachIndexed((index, element) {
      element.orderBy = index;
    });
    if (isHopThua) {
      data['combinePrivateArea'] = dienTichSDRieng;
      data['combineCommonArea'] = dienTichSDChung;
      data['combineAreaWidth'] = dienTichKhuonVien;
      data['combineAreaInPlan'] = dienTichPhuHopQuyHoach;
      data['combineAreaUnPlan'] = dienTichKoPhuHopQuyHoach;
      data['combineAreaNotConsiderValue'] = dienTichMoDuong;
    } else {
      data['facadeLength'] = null;
      data['totalLength'] = null;
      data['combinePrivateArea'] = null;
      data['combineCommonArea'] = null;
      data['combineAreaWidth'] = null;
      data['combineAreaInPlan'] = null;
      data['combineAreaUnPlan'] = null;
      data['combineAreaNotConsiderValue'] = null;
    }
    if (!isShowDiaChi) {
      data['combineLandAddressDetail'] = null;
    }
    return data;
  }

  @override
  int get exportType {
    bool isHopThua =
        assetLandInfors.any((element) => element.isConsolidation == true) ==
            true;
    if (!isHopThua && !xuatThongTinTomTat) {
      return 0;
    } else if (!xuatThongTinTomTat && isHopThua) {
      return 1;
    } else if (xuatThongTinTomTat && !isHopThua) {
      return 2;
    }
    return 0;
  }

  bool get isHopThua =>
      assetLandInfors.any((element) => element.isConsolidation == true) == true;

  bool get isShowDiaChi => !isHopThua && assetLandInfors.length > 1;

  static const topLevelFields = [
    'assetId',
    'assetCode',
    'whoCreate',
    'rmName',
    'rmPhone',
    'dateCreate',
    'dateModify',
    'surveyTime',
    'businessAdvantage',
    'liquidity',
    'currentUseSituation',
    'disputeInfor',
    'note',
    'planningInfor',
    'riskDetails',
    'legalInformations',
    'facadeLength',
    'totalLength',
    'combinePrivateArea',
    'combineCommonArea',
    'combineAreaWidth',
    'combineAreaInPlan',
    'combineAreaUnPlan',
    'combineNote',
    'combineAppraisalLocation',
    'assetLandInfors',
    'combineLandShape',
    'combineAreaNotConsiderValue',
    'combineLandAddressDetail',
    'combineAreaWidthDetail',
  ];
}
