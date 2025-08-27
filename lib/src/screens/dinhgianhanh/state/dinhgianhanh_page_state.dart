// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';

class DinhGiaNhanhPageState extends BaseDetailItemState {
  FastValuationModel detailModel;

  DinhGiaNhanhPageState({
    required super.expandList,
    required this.detailModel,
  });

  @override
  List<Object?> get props => [detailModel.assetId];

  @override
  DinhGiaNhanhPageState copyWith({
    List<ExpandModel>? expandList,
    FastValuationModel? detailModel,
  }) {
    return DinhGiaNhanhPageState(
      detailModel: detailModel ?? this.detailModel,
      expandList: expandList ?? this.expandList,
    );
  }
}
