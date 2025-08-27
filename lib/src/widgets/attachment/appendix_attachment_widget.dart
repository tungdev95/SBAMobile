import 'package:flutter/material.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/widgets/attachment/image_attachment.dart';
import 'package:sba/src/widgets/rounded_textfield.dart';

class AppendixAttachmentWidget extends StatefulWidget {
  final Attachment attachment;
  final Function(String) cancelUpload;
  final Function(String) retryUpload;
  final Function(String) onTextChange;
  const AppendixAttachmentWidget({
    super.key,
    required this.attachment,
    required this.cancelUpload,
    required this.retryUpload,
    required this.onTextChange,
  });

  @override
  State<AppendixAttachmentWidget> createState() =>
      _AppendixAttachmentWidgetState();
}

class _AppendixAttachmentWidgetState extends State<AppendixAttachmentWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.attachment.description ?? '';
  }

  @override
  void didUpdateWidget(covariant AppendixAttachmentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.attachment != oldWidget.attachment) {
      _textEditingController.text = widget.attachment.description ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageAttachment(
          asset: 'null',
          attachment: widget.attachment,
          constraints: const BoxConstraints.tightFor(width: 50, height: 50),
          cancelUpload: widget.cancelUpload,
          retryUpload: widget.retryUpload,
          allowDelete: false,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: RoundedTextField(
            editingController: _textEditingController,
            enabled:
                widget.attachment.uploadState == const UploadState.success(),
            inputFieldModel: InputFieldModel<String>(
              data: widget.attachment.description,
            ),
            onChanged: (newText) {
              widget.onTextChange.call(newText);
              widget.attachment.description = newText;
            },
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton(
          onPressed: () {
            widget.cancelUpload.call(widget.attachment.id);
          },
          icon: const Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
