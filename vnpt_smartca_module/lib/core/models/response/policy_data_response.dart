
import 'dart:convert';

PolicyDataResponse policyDataResponseFromJson(String str) => PolicyDataResponse.fromJson(json.decode(str));

String policyDataResponseToJson(PolicyDataResponse data) => json.encode(data.toJson());

class PolicyDataResponse {
  String? uid;
  String? createdDate;
  List<ND13Content>? nD13Content;
  String? id;
  String? timestamp;

  PolicyDataResponse({
    this.uid,
    this.createdDate,
    this.nD13Content,
    this.id,
    this.timestamp,
  });

  factory PolicyDataResponse.fromJson(Map<String, dynamic> json) => PolicyDataResponse(
    uid: json["uid"],
    createdDate: json["createdDate"],
    nD13Content: json["nD13Content"] == null ? null : List<ND13Content>.from(json["nD13Content"].map((x) => ND13Content.fromJson(x))),
    id: json["id"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "createdDate": createdDate,
    "nD13Content": nD13Content == null ? null : List<dynamic>.from(nD13Content!.map((x) => x.toJson())),
    "id": id,
    "timestamp": timestamp,
  };
}

class ND13Content {
  int? key;
  String? code;
  String? description;
  bool? checked;

  ND13Content({
    this.key,
    this.code,
    this.description,
    this.checked
  });

  factory ND13Content.fromJson(Map<String, dynamic> json) => ND13Content(
    key: json["key"],
    code: json["code"],
    description: json["description"],
    checked: json["checked"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "code": code,
    "description": description,
    "checked": checked,
  };
}
