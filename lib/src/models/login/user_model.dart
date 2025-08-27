// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel extends Equatable with _$UserModel {
  const UserModel._(); // Added constructor
  const factory UserModel({
    String? staffId,
    String? username,
    String? staffName,
    String? phone,
    String? email,
    String? departmentName,
    String? accessToken,
    String? refreshToken,
    String? loginName,
    String? pass,
    String? locationCheckInName,
    String? locationCheckIn,
    String? avatar,
    Position? position,
    CompanyBranch? companyBranch,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);

  bool isLoggedIn() {
    return (accessToken ?? '').isNotEmpty;
  }

  String get fullName => staffName ?? loginName ?? '';
  String get subTitle =>
      companyBranch?.companyBranchName ?? position?.positionName ?? '';

  String get userAvatar =>
      avatar ??
      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1380&t=st=1699976997~exp=1699977597~hmac=4f96fc061e1685d501b0f7c3bc444829bc70b189e8d3a9232272b62e2f150a1c';

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
      ];
}

@JsonSerializable()
class Position {
  final int positionId;
  final String positionName;
  final String term;
  Position({
    this.positionId = 0,
    this.positionName = '',
    this.term = '',
  });

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

@JsonSerializable()
class CompanyBranch {
  final int companyBranchId;
  final String companyBranchName;
  CompanyBranch({
    this.companyBranchId = 0,
    this.companyBranchName = '',
  });

  factory CompanyBranch.fromJson(Map<String, dynamic> json) =>
      _$CompanyBranchFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyBranchToJson(this);
}

@JsonSerializable()
class StaffModel {
  String staffId;
  String staffName;
  String roleCode;
  StaffModel({
    this.staffId = '',
    this.staffName = '',
    this.roleCode = '',
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);
  Map<String, dynamic> toJson() => _$StaffModelToJson(this);
}
