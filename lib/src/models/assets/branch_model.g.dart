// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      branchCode: json['branchCode'] as String?,
      branchName: json['branchName'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'branchCode': instance.branchCode,
      'branchName': instance.branchName,
      'address': instance.address,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
