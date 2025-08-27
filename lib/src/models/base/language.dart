// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class LanguageModel {
  final String code;
  final String title;

  //ui helper
  final String? imageName;

  const LanguageModel({this.code = 'vi', this.title = '', this.imageName = ''});

  factory LanguageModel.initEngLanguage() => const LanguageModel(code: 'en');
  factory LanguageModel.initViLanguage() => const LanguageModel(code: 'vi');
  factory LanguageModel.initWithCode(String? code) {
    return code == 'en'
        ? LanguageModel.initEngLanguage()
        : LanguageModel.initViLanguage();
  }

  static final languagesList = [
    LanguageModel.initViLanguage(),
    LanguageModel.initEngLanguage()
  ];

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);

  @override
  bool operator ==(covariant LanguageModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.title == title &&
        other.imageName == imageName;
  }

  @override
  int get hashCode => code.hashCode ^ title.hashCode ^ imageName.hashCode;
}
