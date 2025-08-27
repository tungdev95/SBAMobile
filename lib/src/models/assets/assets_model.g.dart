// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetsModel _$AssetsModelFromJson(Map<String, dynamic> json) => AssetsModel(
      appraisalFileId: json['appraisalFileId'] as String?,
      proposalCode: json['proposalCode'] as String?,
      reportCode: json['reportCode'] as String?,
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      customerId: json['customerId'] as String?,
      address: json['address'] as String?,
      assetLevelOneId: json['assetLevelOneId'] as int?,
      assetType: $enumDecode(_$AssetsTypeEnumEnumMap, json['assetLevelTwoId'],
          unknownValue: AssetsTypeEnum.bds),
      assetLevelThreeId: json['assetLevelThreeId'] as int?,
      brandCode: json['brandCode'] as String?,
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      surveyGuide: json['surveyGuide'] as String?,
      surveyGuidePhone: json['surveyGuidePhone'] as String?,
      fileStatus: $enumDecodeNullable(_$FileStatusEnumMap, json['fileStatus'],
          unknownValue: FileStatus.unKnown),
      proposalDate: json['proposalDate'] == null
          ? null
          : DateTime.parse(json['proposalDate'] as String),
      assetCommons: (json['assetCommons'] as List<dynamic>?)
          ?.map((e) => AssetCommons.fromJson(e as Map<String, dynamic>))
          .toList(),
      assetImages: (json['assetImages'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      exportType:
          (json['exportType'] as List<dynamic>?)?.map((e) => e as int).toList(),
      transOfficeCode: json['transOfficeCode'] as String?,
      transOffice: json['transOffice'] == null
          ? null
          : TransOffice.fromJson(json['transOffice'] as Map<String, dynamic>),
      rmName: json['rmName'] as String?,
      rmPhone: json['rmPhone'] as String?,
      resultEmail: json['resultEmail'] as String?,
      invoiceEmail: json['invoiceEmail'] as String?,
      surveyTime: json['surveyTime'] == null
          ? null
          : DateTime.parse(json['surveyTime'] as String),
      appraisalDate: json['appraisalDate'] == null
          ? null
          : DateTime.parse(json['appraisalDate'] as String),
      approvedDate: json['approvedDate'] == null
          ? null
          : DateTime.parse(json['approvedDate'] as String),
      assetName: json['assetName'] as String?,
      appraisalPurposeId: json['appraisalPurposeId'] as int?,
      assetLevelThrees: json['assetLevelThrees'] as String?,
      addressDetail: json['addressDetail'] as String?,
      addressStreet: json['addressStreet'] as String?,
      addressWard: json['addressWard'] as String?,
      addressDistrict: json['addressDistrict'] as String?,
      addressProvince: json['addressProvince'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      flowId: json['flowId'] as int?,
      surveySchedules: (json['surveySchedules'] as List<dynamic>?)
              ?.map((e) =>
                  SurveyScheduleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      typeCreated: json['typeCreated'] as int?,
      customerNameByLos: json['customerNameByLos'],
      description: json['description'] as String?,
      appraisalUnit: json['appraisalUnit'] as int?,
      addressCustomDetail: json['addressCustomDetail'] as String?,
      rePricingNumber: json['rePricingNumber'] as int?,
      extraData: json['extraData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$AssetsModelToJson(AssetsModel instance) =>
    <String, dynamic>{
      'appraisalFileId': instance.appraisalFileId,
      'proposalCode': instance.proposalCode,
      'reportCode': instance.reportCode,
      'customer': instance.customer,
      'customerId': instance.customerId,
      'address': instance.address,
      'assetLevelOneId': instance.assetLevelOneId,
      'assetLevelTwoId': _$AssetsTypeEnumEnumMap[instance.assetType]!,
      'assetLevelThreeId': instance.assetLevelThreeId,
      'brandCode': instance.brandCode,
      'branch': instance.branch,
      'surveyGuide': instance.surveyGuide,
      'surveyGuidePhone': instance.surveyGuidePhone,
      'fileStatus': _$FileStatusEnumMap[instance.fileStatus],
      'proposalDate': instance.proposalDate?.toIso8601String(),
      'assetCommons': instance.assetCommons,
      'assetImages': instance.assetImages,
      'exportType': instance.exportType,
      'transOfficeCode': instance.transOfficeCode,
      'transOffice': instance.transOffice,
      'rmName': instance.rmName,
      'rmPhone': instance.rmPhone,
      'resultEmail': instance.resultEmail,
      'invoiceEmail': instance.invoiceEmail,
      'surveyTime': instance.surveyTime?.toIso8601String(),
      'appraisalDate': instance.appraisalDate?.toIso8601String(),
      'approvedDate': instance.approvedDate?.toIso8601String(),
      'assetName': instance.assetName,
      'appraisalPurposeId': instance.appraisalPurposeId,
      'assetLevelThrees': instance.assetLevelThrees,
      'addressDetail': instance.addressDetail,
      'addressStreet': instance.addressStreet,
      'addressWard': instance.addressWard,
      'addressDistrict': instance.addressDistrict,
      'addressProvince': instance.addressProvince,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'flowId': instance.flowId,
      'surveySchedules': lsSurveyScheduleToJson(instance.surveySchedules),
      'typeCreated': instance.typeCreated,
      'customerNameByLos': instance.customerNameByLos,
      'description': instance.description,
      'appraisalUnit': instance.appraisalUnit,
      'addressCustomDetail': instance.addressCustomDetail,
      'rePricingNumber': instance.rePricingNumber,
      'extraData': instance.extraData,
    };

const _$AssetsTypeEnumEnumMap = {
  AssetsTypeEnum.taiSan: 'taiSan',
  AssetsTypeEnum.taoToTrinh: 'taoToTrinh',
  AssetsTypeEnum.toTrinh: 'toTrinh',
  AssetsTypeEnum.doanDuong: 'doanDuong',
  AssetsTypeEnum.bds: 1,
  AssetsTypeEnum.chcc: 2,
  AssetsTypeEnum.duAn: 8,
  AssetsTypeEnum.duToan: 9,
  AssetsTypeEnum.ptdb: 3,
  AssetsTypeEnum.ptdt: 4,
  AssetsTypeEnum.mmtb: 5,
  AssetsTypeEnum.hh: 7,
  AssetsTypeEnum.tsk: 6,
  AssetsTypeEnum.dinhGiaNhanhBDS: 'dinhGiaNhanhBDS',
  AssetsTypeEnum.dinhGiaNhanhCHCC: 'dinhGiaNhanhCHCC',
  AssetsTypeEnum.dinhGiaNhanhPTVT: 'dinhGiaNhanhPTVT',
};

const _$FileStatusEnumMap = {
  FileStatus.unKnown: 'unKnown',
  FileStatus.taoHoSoThuCong: 0,
  FileStatus.daBoSungHSPL: 3,
  FileStatus.chuaCoLichKhaoSat: 7,
  FileStatus.daCoLichKhaoSat: 8,
  FileStatus.dangKhaoSat: 11,
  FileStatus.hoanThanhBBKS: 12,
  FileStatus.choDuyet: 14,
  FileStatus.dangDuyet: 15,
  FileStatus.daDuyet: 16,
  FileStatus.daTuChoiDuyetVaChoDieuChinh: 17,
  FileStatus.daKySo: 19,
  FileStatus.daGuiThongBao: 20,
  FileStatus.choBaoLaiLichKS: -2,
  FileStatus.daGuiKQThamDinh: 99,
};

AssetCommons _$AssetCommonsFromJson(Map<String, dynamic> json) => AssetCommons(
      assetCommonId: json['assetCommonId'] as int?,
      appraisalFileId: json['appraisalFileId'] as String?,
      assetCode: json['assetCode'] as String?,
      climsCode: json['climsCode'] as String?,
      assetLevelThreeId: json['assetLevelThreeId'] as int?,
      extraData: json['extraData'] as Map<String, dynamic>?,
      addressWard: json['addressWard'] as String?,
      addressDistrict: json['addressDistrict'] as String?,
      addressProvince: json['addressProvince'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AssetCommonsToJson(AssetCommons instance) =>
    <String, dynamic>{
      'assetCommonId': instance.assetCommonId,
      'appraisalFileId': instance.appraisalFileId,
      'assetCode': instance.assetCode,
      'climsCode': instance.climsCode,
      'assetLevelThreeId': instance.assetLevelThreeId,
      'addressWard': instance.addressWard,
      'addressDistrict': instance.addressDistrict,
      'addressProvince': instance.addressProvince,
      'description': instance.description,
      'extraData': instance.extraData,
    };

TransOffice _$TransOfficeFromJson(Map<String, dynamic> json) => TransOffice(
      transOfficeCode: json['transOfficeCode'] as String?,
      transOfficeName: json['transOfficeName'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      branchCode: json['branchCode'] as String?,
      createdDate: json['createdDate'] as String?,
      taxCode: json['taxCode'] as String?,
      hibernate: json['hibernate'],
    );

Map<String, dynamic> _$TransOfficeToJson(TransOffice instance) =>
    <String, dynamic>{
      'transOfficeCode': instance.transOfficeCode,
      'transOfficeName': instance.transOfficeName,
      'address': instance.address,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'branchCode': instance.branchCode,
      'createdDate': instance.createdDate,
      'taxCode': instance.taxCode,
      'hibernate': instance.hibernate,
    };
