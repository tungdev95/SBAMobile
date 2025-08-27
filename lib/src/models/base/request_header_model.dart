import 'package:json_annotation/json_annotation.dart';
part 'request_header_model.g.dart';

@JsonSerializable()
class RequestHeaderModel {
  String? oS;
  String? deviceName;
  String? deviceId;
  String? token;
  String? appID;
  String? publicKey;

  RequestHeaderModel(
      {this.oS,
      this.deviceName,
      this.deviceId,
      this.token,
      this.appID = 'APIVinor2021',
      this.publicKey = 'VHlOLkFwcC5BcGkuMjAyMQ=='});
}
