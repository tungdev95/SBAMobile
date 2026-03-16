import 'package:json_annotation/json_annotation.dart';
part 'domain_model.g.dart';

@JsonSerializable()
class DomainModel {
  String? name;
  String? value;
  bool isCheck;
  DomainModel({this.name, this.value, this.isCheck = false});
  factory DomainModel.fromJson(Map<String, dynamic> json) =>
      _$DomainModelFromJson(json);
  Map<String, dynamic> toJson() => _$DomainModelToJson(this);
}
