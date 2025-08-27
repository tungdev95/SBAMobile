// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/utils/uuid.dart';

part 'chcc_info.g.dart';

@JsonSerializable()
class CHCCInfo extends Equatable {
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? id;

  String? assetId;

  String? assetCode;

  int? assetApartmentInforId;

  ///	Số thửa đất
  String? landPlotNumber;

  ///	Số tờ bản đồ
  String? mapSheetNumber;

  ///	Chi tiết địa chỉ thực tế của căn hộ.
  String? realAddressDetail;

  ///	Tên đường thực tế của căn hộ.
  String? realAddressStreet;

  ///	Phường/xã thực tế của căn hộ.
  String? realAddressWard;

  ///	Quận/huyện thực tế của căn hộ.
  String? realAddressDistrict;

  ///	Tỉnh/thành phố thực tế của căn hộ.
  String? realAddressProvince;

  ///	Chi tiết địa chỉ pháp lý của căn hộ.
  String? legalAddressDetail;

  ///	Tên đường pháp lý của căn hộ.
  String? legalAddressStreet;

  ///	Phường/xã pháp lý của căn hộ.
  String? legalAddressWard;

  ///	Quận/huyện pháp lý của căn hộ.
  String? legalAddressDistrict;

  ///	Tỉnh/thành phố pháp lý của căn hộ.
  String? legalAddressProvince;

  ///	Số tầng của toà nhà chứa căn hộ.
  int? legalApartmentNumber;

  ///	Số thang máy hoặc hầm.
  int? numberBasement;

  ///	Tên tòa nhà chứa căn hộ.
  String? nameBuilding;

  ///	Độ rộng đường chính gần căn hộ.
  double? mainRoadWith;

  ///	Vị trí id
  int? positionId;

  ///	Mã căn hộ theo pháp lý.
  String? legalApartmentCode;

  ///	Số tầng của căn hộ theo pháp lý.
  int? legalFloorNo;

  ///	Số phòng ngủ theo pháp lý.
  int? legalNumberBedroom;

  ///	Số phòng vệ sinh theo pháp lý.
  int? legalNumberToilets;

  ///	Nội thất của căn hộ theo pháp lý.
  String? legalFurniture;

  ///	Số mặt thoáng của căn hộ theo pháp lý.
  int? legalFacades;

  ///	Hướng ban công chính của căn hộ theo pháp lý.
  String? legalMainBalconyDirection;

  ///	Diện tích sử dụng riêng theo pháp lý.
  double? legalPrivateUseArea;

  ///	Diện tích sử dụng chung (thông thuỷ) pháp lý
  double? legalClearanceArea;

  ///	Diện tích sàn của tòa nhà chứa căn hộ (tim tường) pháp lý
  double? legalBuildupArea;

  ///	Diện tích mở rộng của căn hộ pháp lý
  double? legalExtendArea;

  String? legalCurrentPrivateUsing;

  ///	Mã căn hộ thực tế.
  String? realApartmentCode;

  ///	Số tầng của căn hộ thực tế.
  int? realFloorNo;

  ///	Số phòng ngủ  thực tế.
  int? realNumberBedroom;

  ///	Số phòng vệ sinh thực tế.
  int? realNumberToilets;

  ///	Nội thất của căn hộ  thực tế.
  String? realFurniture;

  ///	Số mặt thoáng của căn hộ thực tế.
  int? realFacades;

  ///	Hướng ban công chính của căn hộ thực tế.
  String? realMainBalconyDirection;

  ///	Diện tích sử dụng riêng theo địa chỉ thực tế.
  double? realPrivateUseArea;

  ///	Diện tích sử dụng chung (thông thuỷ) thực tế
  double? realClearanceArea;

  ///	Diện tích sàn của tòa nhà chứa căn hộ (tim tường) thực tế
  double? realBuildupArea;

  ///	Diện tích mở rộng của căn hộ
  double? realExtendArea;

  /// Tòa nhà thực tế
  String? realBuilding;

  String? realCurrentPrivateUsing;

  /// Số tầng tòa nhà
  int? numberFloors;

  /// Mô tả vị trí
  String? note;

  String? description;

  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isHopKhoi;

  double? totalApartmentArea;

  String? uses;

  String? usingPurposeTypeId;

  String? termOfLandUse;

  String? utilities;

  CHCCInfo({
    this.id,
    this.assetId,
    required this.assetCode,
    this.landPlotNumber,
    this.mapSheetNumber,
    this.realAddressDetail,
    this.realAddressStreet,
    this.realAddressWard,
    this.realAddressDistrict,
    this.realAddressProvince,
    this.legalAddressDetail,
    this.legalAddressStreet,
    this.legalAddressWard,
    this.legalAddressDistrict,
    this.legalAddressProvince,
    this.legalApartmentNumber,
    this.numberBasement,
    this.nameBuilding,
    this.mainRoadWith,
    this.positionId,
    this.legalApartmentCode,
    this.legalFloorNo,
    this.legalNumberBedroom,
    this.legalNumberToilets,
    this.legalFurniture,
    this.legalFacades,
    this.legalMainBalconyDirection,
    this.legalPrivateUseArea,
    this.legalClearanceArea,
    this.legalBuildupArea,
    this.legalExtendArea,
    this.realApartmentCode,
    this.realFloorNo,
    this.realNumberBedroom,
    this.realNumberToilets,
    this.realFurniture,
    this.realFacades,
    this.realMainBalconyDirection,
    this.realPrivateUseArea,
    this.realClearanceArea,
    this.realBuildupArea,
    this.realExtendArea,
    this.realBuilding,
    this.numberFloors,
    this.note,
    this.assetApartmentInforId,
    this.isHopKhoi = false,
    this.totalApartmentArea,
    this.uses,
    this.usingPurposeTypeId,
    this.termOfLandUse,
    this.description,
    this.utilities,
    this.legalCurrentPrivateUsing,
    this.realCurrentPrivateUsing,
  }) {
    id ??= Uuid().generateV4();
  }

  List<String> get listUtilities => (utilities ?? '').split(',');

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

  bool? get garage {
    return utilities?.contains(UtilitiesApartment.garage.name);
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

  factory CHCCInfo.fromJson(dynamic json) => _$CHCCInfoFromJson(json);
  Map<String?, dynamic> toJson() => _$CHCCInfoToJson(this);

  @override
  List<Object?> get props => [id];

  bool get isValid {
    return nameBuilding != null && positionId != null && description != null;
  }
}
