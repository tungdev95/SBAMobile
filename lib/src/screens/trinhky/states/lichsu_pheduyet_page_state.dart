// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/assets.dart';

class LichSuPheDuyetState extends Equatable {
  final AssetsModel assetsModel;
  final ApprovalSubmissionInfo? item;
  const LichSuPheDuyetState({
    required this.assetsModel,
    this.item,
  });
  @override
  List<Object?> get props => [item];

  LichSuPheDuyetState copyWith({
    AssetsModel? assetsModel,
    ApprovalSubmissionInfo? item,
  }) {
    return LichSuPheDuyetState(
      assetsModel: assetsModel ?? this.assetsModel,
      item: item ?? this.item,
    );
  }
}
