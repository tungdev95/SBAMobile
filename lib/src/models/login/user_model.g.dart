// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      positionId: json['positionId'] as int? ?? 0,
      positionName: json['positionName'] as String? ?? '',
      term: json['term'] as String? ?? '',
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'positionId': instance.positionId,
      'positionName': instance.positionName,
      'term': instance.term,
    };

CompanyBranch _$CompanyBranchFromJson(Map<String, dynamic> json) =>
    CompanyBranch(
      companyBranchId: json['companyBranchId'] as int? ?? 0,
      companyBranchName: json['companyBranchName'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyBranchToJson(CompanyBranch instance) =>
    <String, dynamic>{
      'companyBranchId': instance.companyBranchId,
      'companyBranchName': instance.companyBranchName,
    };

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) => StaffModel(
      staffId: json['staffId'] as String? ?? '',
      staffName: json['staffName'] as String? ?? '',
      roleCode: json['roleCode'] as String? ?? '',
    );

Map<String, dynamic> _$StaffModelToJson(StaffModel instance) =>
    <String, dynamic>{
      'staffId': instance.staffId,
      'staffName': instance.staffName,
      'roleCode': instance.roleCode,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      staffId: json['staffId'] as String?,
      username: json['username'] as String?,
      staffName: json['staffName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      departmentName: json['departmentName'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      loginName: json['loginName'] as String?,
      pass: json['pass'] as String?,
      locationCheckInName: json['locationCheckInName'] as String?,
      locationCheckIn: json['locationCheckIn'] as String?,
      avatar: json['avatar'] as String?,
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      companyBranch: json['companyBranch'] == null
          ? null
          : CompanyBranch.fromJson(
              json['companyBranch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'staffId': instance.staffId,
      'username': instance.username,
      'staffName': instance.staffName,
      'phone': instance.phone,
      'email': instance.email,
      'departmentName': instance.departmentName,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'loginName': instance.loginName,
      'pass': instance.pass,
      'locationCheckInName': instance.locationCheckInName,
      'locationCheckIn': instance.locationCheckIn,
      'avatar': instance.avatar,
      'position': instance.position,
      'companyBranch': instance.companyBranch,
    };
