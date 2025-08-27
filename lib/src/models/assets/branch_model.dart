// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel {
  final String? branchCode;
  final String? branchName;
  final String? address;
  final String? email;
  final String? phoneNumber;
  const BranchModel({
    this.branchCode,
    this.branchName,
    this.address,
    this.email,
    this.phoneNumber,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
