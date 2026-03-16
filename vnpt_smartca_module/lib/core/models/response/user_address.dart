class UserAddress {
  UserAddress({
    required this.provinceId,
    required this.provinceName,
    required this.wardId,
    required this.wardName,
    required this.streetName,
    required this.diaChi,
    this.districtId,
  });
  late String provinceId;
  late String provinceName;
  late String wardId;
  late String wardName;
  String? streetName;
  String? districtId;
  String? diaChi;

  UserAddress.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'] ?? "";
    provinceName = json['provinceName'] ?? "";
    wardId = json['wardId'] ?? "";
    wardName = json['wardName'] ?? "";
    streetName = json['streetName'] ?? "";
    diaChi = "$streetName, $wardName, $provinceName".replaceAll(", ,", ""); //json['diaChi'] ?? "";
    districtId = json['districtId'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['provinceId'] = provinceId;
    data['provinceName'] = provinceName;
    data['wardId'] = wardId;
    data['wardName'] = wardName;
    data['streetName'] = streetName;
    data['diaChi'] = diaChi;
    data['districtId'] = districtId;
    return data;
  }

  updateName() {
    try {
      List<String>? names = diaChi?.split(",");
      if (names == null) {
        return;
      }
      wardName = names[0].trim();
      provinceName = names[1].trim();
    } catch (e) {
      // todo
    }
  }
}
