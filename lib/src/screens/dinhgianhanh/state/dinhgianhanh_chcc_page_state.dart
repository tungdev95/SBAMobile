// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';

class DinhGiaNhanhCHCCPageState extends BaseDetailItemState {
  CHCCFastValModel detailModel;

  DinhGiaNhanhCHCCPageState({
    required super.expandList,
    required this.detailModel,
  });

  @override
  List<Object?> get props => [detailModel.assetId];

  @override
  DinhGiaNhanhCHCCPageState copyWith({
    List<ExpandModel>? expandList,
    CHCCFastValModel? detailModel,
  }) {
    return DinhGiaNhanhCHCCPageState(
      detailModel: detailModel ?? this.detailModel,
      expandList: expandList ?? this.expandList,
    );
  }
}
