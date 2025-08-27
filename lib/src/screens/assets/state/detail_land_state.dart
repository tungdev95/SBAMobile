// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/state/base_detail_item_state.dart';

class DetailLandState extends BaseDetailItemState {
  AssetLandInfo landInfo;
  RealEstateModel detailModel;
  DetailLandState({
    required this.landInfo,
    required super.expandList,
    required this.detailModel,
  });

  @override
  DetailLandState copyWith({
    AssetLandInfo? landInfo,
    List<ExpandModel>? expandList,
    RealEstateModel? detailModel,
  }) {
    return DetailLandState(
      landInfo: landInfo ?? this.landInfo,
      expandList: expandList ?? this.expandList,
      detailModel: detailModel ?? this.detailModel,
    );
  }

  @override
  List<Object?> get props => [landInfo.id];
}

class DetailData extends Equatable {
  AssetLandInfo landInfo;
  RealEstateModel detailModel;
  DetailData({
    required this.landInfo,
    required this.detailModel,
  });

  DetailData copyWith({
    AssetLandInfo? landInfo,
    RealEstateModel? detailModel,
  }) {
    return DetailData(
      landInfo: landInfo ?? this.landInfo,
      detailModel: detailModel ?? this.detailModel,
    );
  }

  @override
  List<Object?> get props => [landInfo.id, detailModel.assetId];
}
