import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/widgets/attachment/upload_progress_indicator.dart';

class AttachmentUploadStateBuilder extends StatelessWidget {
  const AttachmentUploadStateBuilder({
    super.key,
    required this.attachment,
    this.asset,
    required this.cancelUpload,
    required this.retryUpload,
  });

  final dynamic asset;
  final Attachment attachment;
  final Function(String) cancelUpload;
  final Function(String) retryUpload;

  @override
  Widget build(BuildContext context) {
    if (attachment.uploadState.isSuccess) {
      return const Offstage();
    }

    final attachmentId = attachment.id;

    _InProgressState inProgress(context, int sent, int total) {
      return _InProgressState(
        sent: sent,
        total: total,
        attachmentId: attachmentId,
        cancelUpload: cancelUpload,
      );
    }

    _FailedState failed(context, error) {
      return _FailedState(
        error: error,
        assetId: '',
        attachmentId: attachmentId,
        retryUpload: retryUpload,
      );
    }

    _SuccessState success(context) => _SuccessState();

    _PreparingState preparing(context) => _PreparingState(
          attachmentId: attachmentId,
          cancelUpload: cancelUpload,
        );

    return attachment.uploadState.when(
      preparing: () => preparing(context),
      inProgress: (sent, total) => inProgress(context, sent, total),
      success: () => success(context),
      failed: (error) => failed(context, error),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    this.icon,
    this.onPressed,
  });

  final Widget? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: RawMaterialButton(
        elevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        onPressed: onPressed,
        // fillColor: ChatThemeData.of(context).colorTheme.overlayDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: icon,
      ),
    );
  }
}

class _PreparingState extends StatelessWidget {
  const _PreparingState({
    required this.attachmentId,
    required this.cancelUpload,
  });

  final String attachmentId;
  final Function(String) cancelUpload;

  @override
  Widget build(BuildContext context) {
    // final channel = context.read<ChannelMessagePageCubit>().channel;
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: _IconButton(
            icon: const Icon(
              Icons.close,
              // color: ChatThemeData.of(context).colorTheme.barsBg,
            ),
            onPressed: () => cancelUpload.call(attachmentId),
          ),
        ),
        Center(
          child: UploadProgressIndicator(
            uploaded: 0,
            total: double.maxFinite.toInt(),
          ),
        ),
      ],
    );
  }
}

class _InProgressState extends ConsumerWidget {
  const _InProgressState({
    required this.sent,
    required this.total,
    required this.attachmentId,
    required this.cancelUpload,
  });

  final int sent;
  final int total;
  final String attachmentId;
  final Function(String) cancelUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      // alignment: Alignment.topRight,
      child: UploadProgressIndicator(
        uploaded: sent,
        total: total,
      ),
    );
  }
}

class _FailedState extends StatelessWidget {
  const _FailedState({
    this.error,
    required this.assetId,
    required this.attachmentId,
    required this.retryUpload,
  });

  final String? error;
  final String assetId;
  final String attachmentId;
  final Function(String) retryUpload;

  @override
  Widget build(BuildContext context) {
    // final channel = context.read<ChannelMessagePageCubit>().channel;
    // final theme = ChatThemeData.of(context);
    return Center(
      child: _IconButton(
        // icon: Assets.images.chat.iconRetry.svg(
        //   color: theme.colorTheme.barsBg,
        // ),
        icon: const Icon(Icons.refresh),
        onPressed: () {
          retryUpload.call(attachmentId);
        },
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CircleAvatar(
          // backgroundColor: ChatThemeData.of(context).colorTheme.overlayDark,
          maxRadius: 12,
          // child: SvgIcon.check(
          //   color: ChatTheme.of(context).colorTheme.barsBg,
          // ),
          child: Icon(
            Icons.check,
            // color: ChatThemeData.of(context).colorTheme.barsBg,
          )),
    );
  }
}
