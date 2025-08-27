import 'package:flutter/material.dart';
import 'package:sba/src/models/assets/assets.dart';

/// Enum for identifying type of attachment
enum AttachmentSource {
  /// Attachment is attached
  local,

  /// Attachment is uploaded
  network;

  T when<T>({
    required T Function() local,
    required T Function() network,
  }) {
    switch (this) {
      case AttachmentSource.local:
        return local();
      case AttachmentSource.network:
        return network();
    }
  }
}

abstract class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({
    super.key,
    required this.asset,
    required this.attachment,
    this.constraints,
    AttachmentSource? source,
  }) : _source = source;

  /// Contraints of attachments
  final BoxConstraints? constraints;

  final AttachmentSource? _source;

  /// The message that [attachment] is associated with
  final dynamic asset;

  /// The [Attachment] to display
  final Attachment attachment;

  /// Getter for source of attachment
  AttachmentSource get source =>
      _source ??
      (attachment.file != null
          ? AttachmentSource.local
          : AttachmentSource.network);
}
