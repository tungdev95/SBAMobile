import 'package:json_annotation/json_annotation.dart';
part 'map_detail_model.g.dart';

@JsonSerializable()
class MapDetailModel {
  @JsonKey(name: 'address_components')
  List<AddressComponents>? addressComponents;
  @JsonKey(name: 'adr_address')
  String? adrAddress;
  @JsonKey(name: 'formatted_address')
  String? formattedAddress;
  @JsonKey(name: 'geometry')
  Geometry? geometry;
  String? icon;
  String? name;
  @JsonKey(name: 'place_id')
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  @JsonKey(name: 'utc_offset')
  int? utcOffset;

  MapDetailModel(
      {this.addressComponents,
      this.adrAddress,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.name,
      this.placeId,
      this.reference,
      this.types,
      this.url,
      this.utcOffset});

  factory MapDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MapDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$MapDetailModelToJson(this);
}

@JsonSerializable()
class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  factory AddressComponents.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsFromJson(json);
  Map<String, dynamic> toJson() => _$AddressComponentsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none)
class Geometry {
  Location? location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none)
class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
