import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:sba/src/utils/utils.dart';

class PhotoViewerWidget extends HookConsumerWidget {
  final List<Attachment>? lsImage;
  final int index;

  const PhotoViewerWidget({super.key, this.lsImage, this.index = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController(initialPage: index);
    return Material(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: lsImage?.length ?? 0,
              itemBuilder: (context, index) {
                var item = lsImage?[index];
                final host = ref.read(dioProvider).options.baseUrl;
                return PhotoView(
                  imageProvider: (item?.imageDownloadUrl == null)
                      ? (item?.file?.bytes != null
                          ? Image.memory(item!.file!.bytes!).image
                          : Image.file(File(item!.file!.path!)).image)
                      : CachedNetworkImageProvider(
                          '$host/${item?.imageDownloadUrl ?? ''}',
                        ),
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  loadingBuilder: (context, _) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  },
                  maxScale: PhotoViewComputedScale.covered,
                  minScale: PhotoViewComputedScale.contained,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(
                top: context.padding.top,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.5),
                    Colors.black.withOpacity(.0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
