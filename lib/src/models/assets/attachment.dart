import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:uuid/uuid.dart';

import 'package:sba/src/models/assets/assets.dart';

part 'attachment.g.dart';

/// The class that contains the information about an attachment
@JsonSerializable(includeIfNull: false)
class Attachment extends Equatable {
  /// Constructor used for json serialization
  Attachment({
    String? id,
    String? title,
    this.file,
    this.fileSize,
    this.mediaType,
    this.appraisalFileId,
    this.ecmId,
    this.type,
    this.description,
    this.filename,
    this.whoUpload,
    this.dateUpload,
    UploadState? uploadState,
  })  : id = id ?? const Uuid().v4(),
        localUri = file?.path != null ? Uri.parse(file?.path ?? '') : null {
    this.uploadState = uploadState ??
        (imageDownloadUrl != null
            ? const UploadState.success()
            : const UploadState.preparing());
  }

  /// Create a new instance from a json
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  String? title;
  String? filename;
  String? appraisalFileId;
  String? ecmId;
  String? description;
  @JsonKey(unknownEnumValue: ImageType.location)
  ImageType? type;
  String? whoUpload;
  DateTime? dateUpload;

  String? get imageDownloadUrl {
    if (ecmId == null) return null;
    return 'bussiness/api/v1/loadECMImage/$ecmId';
  }

  String? get fileDownloadUrl {
    if (ecmId == null) return null;
    return 'bussiness/api/v1/downloadECMFile/legalDocument/$ecmId';
  }

  final Uri? localUri;

  /// The file present inside this attachment.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AttachmentFile? file;

  @JsonKey(includeToJson: false, includeFromJson: false)
  late final UploadState uploadState;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final String id;

  @JsonKey(includeToJson: false, includeFromJson: false)
  int? fileSize;

  // @JsonKey(includeToJson: false, includeFromJson: false)
  String? mediaType;

  /// Serialize to json
  Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  @override
  List<Object?> get props =>
      [id, file, uploadState, filename, mediaType, whoUpload];

  Attachment copyWith({
    AttachmentFile? file,
    UploadState? uploadState,
    String? id,
    String? appraisalFileId,
    String? ecmId,
    ImageType? type,
    String? description,
    String? filename,
    String? mediaType,
    DateTime? dateUpload,
  }) {
    return Attachment(
      file: file ?? this.file,
      uploadState: uploadState ?? this.uploadState,
      id: id ?? this.id,
      ecmId: ecmId ?? this.ecmId,
      type: type ?? this.type,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      mediaType: mediaType ?? this.mediaType,
      dateUpload: dateUpload ?? this.dateUpload,
    );
  }
}
