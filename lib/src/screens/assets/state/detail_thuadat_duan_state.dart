// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';

class DetailThuaDatState extends BaseDetailItemState {
  AssetProjectInfo info;
  DetailThuaDatState({
    required this.info,
    required super.expandList,
  });

  @override
  DetailThuaDatState copyWith({
    AssetProjectInfo? info,
    List<ExpandModel>? expandList,
  }) {
    return DetailThuaDatState(
      info: info ?? this.info,
      expandList: expandList ?? this.expandList,
    );
  }
}

class DetailThuaDatDuAnData extends Equatable {
  AssetProjectInfo info;
  DetailThuaDatDuAnData({
    required this.info,
  });

  @override
  List<Object?> get props => [info.id];
}
