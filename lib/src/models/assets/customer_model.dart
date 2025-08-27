// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable {
  final String? customerId;
  final String? customerName;
  final int? customerTypeId;
  final CustomerType? customerType;
  final String? taxCode;
  final String? personIdentification;
  final String? address;
  final String? phoneNumber;
  final String? representator;
  final String? position;
  final DateTime? dateCreate;
  final DateTime? dateModify;
  final int? status;
  const CustomerModel({
    this.customerId,
    this.customerName,
    this.customerTypeId,
    this.customerType,
    this.taxCode,
    this.personIdentification,
    this.address,
    this.phoneNumber,
    this.representator,
    this.position,
    this.dateCreate,
    this.dateModify,
    this.status,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  CustomerModel copyWith({
    String? customerId,
    String? customerName,
    int? customerTypeId,
    CustomerType? customerType,
    String? taxCode,
    String? personIdentification,
    String? address,
    String? phoneNumber,
    String? representator,
    String? position,
    DateTime? dateCreate,
    DateTime? dateModify,
    int? status,
  }) {
    return CustomerModel(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerTypeId: customerTypeId ?? this.customerTypeId,
      customerType: customerType ?? this.customerType,
      taxCode: taxCode ?? this.taxCode,
      personIdentification: personIdentification ?? this.personIdentification,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      representator: representator ?? this.representator,
      position: position ?? this.position,
      dateCreate: dateCreate ?? this.dateCreate,
      dateModify: dateModify ?? this.dateModify,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        customerId,
        customerName,
        customerTypeId,
        customerType,
        taxCode,
        personIdentification,
        address,
        phoneNumber,
        representator,
        position,
        dateCreate,
        dateModify,
        status,
      ];
}

@JsonSerializable()
class CustomerType extends Equatable {
  final int? customerTypeId;
  final String? customerTypeName;
  final String? description;

  const CustomerType({
    this.customerTypeId,
    this.customerTypeName,
    this.description,
  });

  factory CustomerType.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerTypeToJson(this);

  @override
  List<Object?> get props => [
        customerTypeId,
        customerTypeName,
        description,
      ];
}
