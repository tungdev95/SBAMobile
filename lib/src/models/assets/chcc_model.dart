// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/assets/chcc_info.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/serializer.dart';

import 'assets.dart';
part 'chcc_model.g.dart';

@JsonSerializable()
class CHCCModel extends BaseDetailModel {
  @JsonKey(defaultValue: [])
  List<CHCCInfo> assetApartmentInfors;
  double? combinePrivateArea;
  String? combineNote;
  String? utilities;
  String? combineAppraisalLocation;
  List<String> get listUtilities => (utilities ?? '').split(',');

  bool? get garage {
    return utilities?.contains(UtilitiesApartment.garage.name);
  }

  double? get dienTichSuDungRiengHopKhoi {
    final result = assetApartmentInfors.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.realPrivateUseArea ?? 0.0));
    if (result == 0.0) return null;
    return result;
  }

  void addNewUtils(String name) {
    utilities = [...listUtilities, name].join(',');
  }

  void removeUtils(String name) {
    utilities = ([...listUtilities]..removeWhere((element) => element == name))
        .join(',');
  }

  void updateUtils(bool? isCheck, String name) {
    if (isCheck == true) {
      addNewUtils(name);
    } else {
      removeUtils(name);
    }
  }

  bool? get pool {
    return utilities?.contains(UtilitiesApartment.pool.name);
  }

  bool? get innerPark {
    return utilities?.contains(UtilitiesApartment.innerPark.name);
  }

  bool? get commercialServiceArea {
    return utilities?.contains(UtilitiesApartment.commercialServiceArea.name);
  }

  bool? get elevator {
    return utilities?.contains(UtilitiesApartment.elevator.name);
  }

  bool? get hospitalSchoolPreschool {
    return utilities?.contains(UtilitiesApartment.hospitalSchoolPreschool.name);
  }

  bool? get receptionHall {
    return utilities?.contains(UtilitiesApartment.receptionHall.name);
  }

  CHCCModel({
    required super.legalInformations,
    required super.riskDetails,
    required super.assetId,
    required super.assetCode,
    super.whoCreate,
    super.dateCreate,
    super.dateModify,
    super.businessAdvantage,
    super.liquidity,
    super.currentUseSituation,
    super.disputeInfor,
    super.note,
    super.planningInfor,
    required this.assetApartmentInfors,
    this.combinePrivateArea,
    this.combineNote,
    super.rmName,
    super.rmPhone,
    super.surveyTime,
    this.utilities,
    this.combineAppraisalLocation,
  }) {
    planningInfor ??= 'Không';
    liquidity ??= '2';
    disputeInfor ??= 'Không tranh chấp.';
  }

  factory CHCCModel.fromJson(dynamic json) => _$CHCCModelFromJson(
      Serializer.moveToExtraDataFromRoot(json, topLevelFields));

  Map<String, dynamic> toJson() {
    final data = Serializer.moveFromExtraDataToRoot(_$CHCCModelToJson(this));
    if (!isShowDiaChi) {
      data['combineAppraisalLocation'] = null;
    }
    return data;
  }

  @override
  int get exportType => 0;

  bool get isHopKhoi =>
      assetApartmentInfors.firstWhereOrNull((element) => element.isHopKhoi) !=
      null;

  bool get isShowDiaChi => !isHopKhoi && assetApartmentInfors.length > 1;

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
    'assetApartmentInfors',
    'combinePrivateArea',
    'combineNote',
    'utilities',
    'combineAppraisalLocation',
  ];
}
