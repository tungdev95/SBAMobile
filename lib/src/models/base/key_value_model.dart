import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'key_value_model.g.dart';

@JsonSerializable()
class KeyValueModel extends Equatable {
  int? id;
  String? title;
  String? value;
  String? key;
  Map<String, dynamic>? otherField;

  KeyValueModel({this.id, this.title, this.value, this.key, this.otherField}) {
    if (key == null && id != null) {
      key = id.toString();
    }
  }
  factory KeyValueModel.fromJson(dynamic json) => _$KeyValueModelFromJson(json)
    ..title ??= json['name']
    ..value ??= json['name'] ?? json['title']
    ..key ??= json['id'].toString();
  Map<String, dynamic> toJson() => _$KeyValueModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        key,
      ];

  bool get isOther => id == -1 || key == '-1';
}
