// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'ptdb_dropdown_model.g.dart';

@JsonSerializable()
class WheelFormula {
  int wheelFormulaId;
  String wheelFormulaName;
  WheelFormula({
    this.wheelFormulaId = -1,
    this.wheelFormulaName = '',
  });
  factory WheelFormula.fromJson(Map<String, dynamic> json) =>
      _$WheelFormulaFromJson(json);
  Map<String, dynamic> toJson() => _$WheelFormulaToJson(this);
}

@JsonSerializable()
class GearBox {
  int gearBoxId;
  String gearBoxName;
  GearBox({
    this.gearBoxId = -1,
    this.gearBoxName = '',
  });

  factory GearBox.fromJson(Map<String, dynamic> json) =>
      _$GearBoxFromJson(json);
  Map<String, dynamic> toJson() => _$GearBoxToJson(this);
}

@JsonSerializable()
class Fuel {
  int fuelId;
  String fuelName;

  Fuel({
    this.fuelId = -1,
    this.fuelName = '',
  });

  factory Fuel.fromJson(Map<String, dynamic> json) => _$FuelFromJson(json);
  Map<String, dynamic> toJson() => _$FuelToJson(this);
}

@JsonSerializable()
class Country {
  int id;
  String vnName;
  Country({
    this.id = -1,
    this.vnName = '',
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class Vehicle {
  int roadVehicleBrandId;
  String roadVehicleBrandName;
  Vehicle({
    this.roadVehicleBrandId = 0,
    this.roadVehicleBrandName = '',
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
