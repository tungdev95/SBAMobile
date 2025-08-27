// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/src/models/assets/enum.dart';

class DigitalSignDataState extends Equatable {
  final String? appraisalFilesId;
  final FileStatus? fileStatus;
  const DigitalSignDataState({
    required this.appraisalFilesId,
    required this.fileStatus,
  });

  @override
  List<Object?> get props => [appraisalFilesId, fileStatus];
}
