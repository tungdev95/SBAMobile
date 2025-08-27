// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';

class KetQuaDinhGiaNhanhState extends Equatable {
  FastValuationModel detail;
  KetQuaDinhGiaNhanhState({
    required this.detail,
  });

  @override
  List<Object?> get props => [detail.id];
}
