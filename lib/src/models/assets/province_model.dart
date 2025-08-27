// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'province_model.g.dart';

@JsonSerializable()
class ProvinceModel extends Equatable {
  String? code;
  String? name;
  String? fullName;
  ProvinceModel({
    this.code,
    this.name,
    this.fullName,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);

  @override
  List<Object?> get props => [code, name, fullName];
}
