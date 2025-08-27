// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';

class PdfViewState {
  AssetsModel? assetsModel;
  AttachmentFile? data;
  String? url;
  ApprovalSubmissionInfo? submissionInfo;
  SubmissionDetailModel? submissionDetail;
  String? yKien;
  bool? coQuyenDuyet;
  bool? coQuyenKySo;
  List<ApprovalHistory>? lichSuToTrinh;
  PdfViewState({
    this.assetsModel,
    this.data,
    this.url,
    this.submissionInfo,
    this.submissionDetail,
    this.yKien,
    this.coQuyenDuyet,
    this.coQuyenKySo,
    this.lichSuToTrinh,
  });

  PdfViewState copyWith({
    AssetsModel? assetsModel,
    AttachmentFile? data,
    String? url,
    ApprovalSubmissionInfo? submissionInfo,
    SubmissionDetailModel? submissionDetail,
    String? yKien,
    bool? coQuyenDuyet,
    bool? coQuyenKySo,
    List<ApprovalHistory>? lichSuToTrinh,
  }) {
    return PdfViewState(
      assetsModel: assetsModel ?? this.assetsModel,
      data: data ?? this.data,
      url: url ?? this.url,
      submissionInfo: submissionInfo ?? this.submissionInfo,
      submissionDetail: submissionDetail ?? this.submissionDetail,
      yKien: yKien ?? this.yKien,
      coQuyenDuyet: coQuyenDuyet ?? this.coQuyenDuyet,
      coQuyenKySo: coQuyenKySo ?? this.coQuyenKySo,
      lichSuToTrinh: lichSuToTrinh ?? this.lichSuToTrinh,
    );
  }
}
