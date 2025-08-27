// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';

class KetQuaDinhGiaNhanhCHCCState extends Equatable {
  CHCCFastValModel detail;
  KetQuaDinhGiaNhanhCHCCState({
    required this.detail,
  });

  @override
  List<Object?> get props => [detail.id];

  KetQuaDinhGiaNhanhCHCCState copyWith({
    CHCCFastValModel? detail,
  }) {
    return KetQuaDinhGiaNhanhCHCCState(
      detail: detail ?? this.detail,
    );
  }
}
