// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ptdb_dropdown_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WheelFormula _$WheelFormulaFromJson(Map<String, dynamic> json) => WheelFormula(
      wheelFormulaId: json['wheelFormulaId'] as int? ?? -1,
      wheelFormulaName: json['wheelFormulaName'] as String? ?? '',
    );

Map<String, dynamic> _$WheelFormulaToJson(WheelFormula instance) =>
    <String, dynamic>{
      'wheelFormulaId': instance.wheelFormulaId,
      'wheelFormulaName': instance.wheelFormulaName,
    };

GearBox _$GearBoxFromJson(Map<String, dynamic> json) => GearBox(
      gearBoxId: json['gearBoxId'] as int? ?? -1,
      gearBoxName: json['gearBoxName'] as String? ?? '',
    );

Map<String, dynamic> _$GearBoxToJson(GearBox instance) => <String, dynamic>{
      'gearBoxId': instance.gearBoxId,
      'gearBoxName': instance.gearBoxName,
    };

Fuel _$FuelFromJson(Map<String, dynamic> json) => Fuel(
      fuelId: json['fuelId'] as int? ?? -1,
      fuelName: json['fuelName'] as String? ?? '',
    );

Map<String, dynamic> _$FuelToJson(Fuel instance) => <String, dynamic>{
      'fuelId': instance.fuelId,
      'fuelName': instance.fuelName,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as int? ?? -1,
      vnName: json['vnName'] as String? ?? '',
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'vnName': instance.vnName,
    };

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      roadVehicleBrandId: json['roadVehicleBrandId'] as int? ?? 0,
      roadVehicleBrandName: json['roadVehicleBrandName'] as String? ?? '',
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'roadVehicleBrandId': instance.roadVehicleBrandId,
      'roadVehicleBrandName': instance.roadVehicleBrandName,
    };
