// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  bool isEnableSignature;

  SettingState({
    this.isEnableSignature = false,
  });

  @override
  List<Object?> get props => [isEnableSignature];

  SettingState copyWith({
    bool? isEnableSignature,
  }) {
    return SettingState(
      isEnableSignature: isEnableSignature ?? this.isEnableSignature,
    );
  }
}
