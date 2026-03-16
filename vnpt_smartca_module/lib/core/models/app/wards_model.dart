import 'category_model.dart';

class WardsModel extends CategoryModel {
  int wardId;
  String wardName;
  final int? provinceId;
  final String? provinceName;
  final String? provinceCode;
  final String? postalCode;
  final int? oldProvinceId;
  final String? oldProvinceCode;
  final String? oldProvinceName;
  final int? oldWardId;
  final String? oldWardName;

  WardsModel({
    this.wardId = 0,
    this.wardName = "",
    this.provinceId = 0,
    this.provinceName = "",
    this.provinceCode = "",
    this.postalCode = "",
    this.oldProvinceId = 0,
    this.oldProvinceCode = "",
    this.oldProvinceName = "",
    this.oldWardId = 0,
    this.oldWardName = "",
  });

  WardsModel.fromJson(Map<String, dynamic> json)
      : wardId = json['wardId'],
        wardName = json['wardName'],
        provinceId = json['provinceId'],
        provinceName = json['provinceName'],
        postalCode = json['postalCode'],
        provinceCode = json['provinceCode'],
        oldProvinceId = json['oldProvinceId'],
        oldProvinceCode = json['oldProvinceCode'],
        oldProvinceName = json['oldProvinceName'],
        oldWardId = json['oldWardId'],
        oldWardName = json['oldWardName'];

  @override
  String get name {
    return wardName;
  }
}
