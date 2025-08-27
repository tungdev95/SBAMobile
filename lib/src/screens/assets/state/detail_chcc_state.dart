// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sba/src/models/assets/chcc_info.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/state/base_detail_item_state.dart';

class DetailCHCCState extends BaseDetailItemState {
  CHCCInfo chccInfo;
  CHCCModel detailModel;

  DetailCHCCState({
    required this.chccInfo,
    required this.detailModel,
    super.expandList = const <ExpandModel>[],
  });

  @override
  DetailCHCCState copyWith({
    CHCCInfo? chccInfo,
    CHCCModel? detailModel,
    List<ExpandModel>? expandList,
  }) {
    return DetailCHCCState(
      chccInfo: chccInfo ?? this.chccInfo,
      detailModel: detailModel ?? this.detailModel,
      expandList: expandList ?? this.expandList,
    );
  }
}

class DetailCHCCData extends Equatable {
  CHCCInfo chccInfo;
  CHCCModel detailModel;
  DetailCHCCData({
    required this.chccInfo,
    required this.detailModel,
  });


  @override
  List<Object?> get props => [chccInfo.id, detailModel.assetId];

  DetailCHCCData copyWith({
    CHCCInfo? chccInfo,
    CHCCModel? detailModel,
  }) {
    return DetailCHCCData(
      chccInfo: chccInfo ?? this.chccInfo,
      detailModel: detailModel ?? this.detailModel,
    );
  }
}

