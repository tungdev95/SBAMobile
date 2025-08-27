// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/src/models/base/base.dart';

class BaseDetailItemState extends Equatable {
  List<ExpandModel> expandList;
  BaseDetailItemState({
    required this.expandList,
  });

  BaseDetailItemState copyWith({
    List<ExpandModel>? expandList,
  }) {
    return BaseDetailItemState(
      expandList: expandList ?? this.expandList,
    );
  }

  @override
  List<Object?> get props => [];
}
