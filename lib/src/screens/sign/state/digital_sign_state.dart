// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:sba/src/models/assets/enum.dart';

class DigitalSignState extends Equatable {
  String appraisalFilesId;
  int pageIndex;
  Uint8List? tbkqThamDinh;
  Uint8List? kqThamDinh;
  FileStatus? fileStatus;
  bool? coQuyenKySo;

  DigitalSignState({
    required this.appraisalFilesId,
    this.pageIndex = 1,
    this.tbkqThamDinh,
    this.kqThamDinh,
    this.fileStatus,
    this.coQuyenKySo,
  });

  @override
  List<Object?> get props => [appraisalFilesId, coQuyenKySo];

  DigitalSignState copyWith({
    String? appraisalFilesId,
    int? pageIndex,
    Uint8List? tbkqThamDinh,
    Uint8List? kqThamDinh,
    FileStatus? fileStatus,
    bool? coQuyenKySo,
  }) {
    return DigitalSignState(
      appraisalFilesId: appraisalFilesId ?? this.appraisalFilesId,
      pageIndex: pageIndex ?? this.pageIndex,
      tbkqThamDinh: tbkqThamDinh ?? this.tbkqThamDinh,
      kqThamDinh: kqThamDinh ?? this.kqThamDinh,
      fileStatus: fileStatus ?? this.fileStatus,
      coQuyenKySo: coQuyenKySo ?? this.coQuyenKySo,
    );
  }
}
