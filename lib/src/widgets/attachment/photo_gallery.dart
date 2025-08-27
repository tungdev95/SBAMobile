import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart'
    show AssetEntity, ThumbnailFormat, ThumbnailSize;
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/widgets/attachment/paged_value_scrollview.dart';
import 'package:sba/src/widgets/attachment/photo_gallery_controller.dart';
import 'package:sba/src/widgets/attachment/photo_gallery_tile.dart';
import 'package:sba/src/widgets/scrollview/scroll_view_empty_widget.dart';
import 'package:sba/src/widgets/scrollview/scroll_view_indexed_widget_builder.dart';
import 'package:sba/src/widgets/scrollview/scroll_view_load_more_error.dart';
import 'package:sba/src/widgets/scrollview/scroll_view_load_more_indicator.dart';
import 'package:sba/src/widgets/scrollview/scroll_view_loading_widget.dart';

/// Default grid delegate  for [PhotoGallery].
const defaultPhotoGalleryDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3,
  mainAxisSpacing: 2,
  crossAxisSpacing: 2,
);

typedef PhotoGalleryIndexedWidgetBuilder
    = ScrollViewIndexedWidgetBuilder<AssetEntity, PhotoGalleryTile>;

/// Widget used to display a gallery of photos in the form of grid.
class PhotoGallery extends StatelessWidget {
  /// Creates a [PhotoGallery] widget.
  const PhotoGallery({
    super.key,
    required this.controller,
    this.gridDelegate = defaultPhotoGalleryDelegate,
    this.itemBuilder,
    this.emptyBuilder,
    // this.loadMoreErrorBuilder,
    this.loadMoreIndicatorBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onMediaTap,
    this.onMediaLongPress,
    this.loadMoreTriggerIndex = 3,
    this.scrollController,
    this.thumbnailSize = const ThumbnailSize(400, 400),
    this.thumbnailFormat = ThumbnailFormat.jpeg,
    this.thumbnailQuality = 100,
    this.thumbnailScale = 1,
    this.shrinkWrap = false,
    this.padding,
  });

  /// The [PhotoGalleryController] used to control the grid of users.
  final PhotoGalleryController controller;

  final SliverGridDelegate gridDelegate;

  /// A builder that is called to build items in the [PagedValueGridView].
  final PhotoGalleryIndexedWidgetBuilder? itemBuilder;

  /// A builder that is called to build the empty state of the grid.
  final WidgetBuilder? emptyBuilder;

  /// A builder that is called to build the load more error state of the grid.
  // final PagedValueScrollViewLoadMoreErrorBuilder? loadMoreErrorBuilder;

  /// A builder that is called to build the load more indicator of the grid.
  final WidgetBuilder? loadMoreIndicatorBuilder;

  /// A builder that is called to build the loading state of the grid.
  final WidgetBuilder? loadingBuilder;

  /// A builder that is called to build the error state of the grid.
  final Widget Function(BuildContext)? errorBuilder;

  /// Called when the user taps this grid tile.
  final void Function(AssetEntity)? onMediaTap;

  /// Called when the user long-presses on this grid tile.
  final void Function(AssetEntity)? onMediaLongPress;

  /// The index to take into account when triggering [controller.loadMore].
  final int loadMoreTriggerIndex;

  final ScrollController? scrollController;

  /// The thumbnail size.
  final ThumbnailSize thumbnailSize;

  /// {@macro photo_manager.ThumbnailFormat}
  final ThumbnailFormat thumbnailFormat;

  /// The quality value for the thumbnail.
  ///
  /// Valid from 1 to 100.
  /// Defaults to 100.
  final int thumbnailQuality;

  /// Scale of the image.
  final double thumbnailScale;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return PagedValueGridView<int, AssetEntity>(
      controller: controller,
      scrollController: scrollController,
      loadMoreTriggerIndex: loadMoreTriggerIndex,
      gridDelegate: gridDelegate,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemBuilder: (context, mediaList, index) {
        final media = mediaList[index];
        final onTap = onMediaTap;
        final onLongPress = onMediaLongPress;

        final streamPhotoGalleryTile = PhotoGalleryTile(
          media: media,
          onTap: onTap == null ? null : () => onTap(media),
          onLongPress: onLongPress == null ? null : () => onLongPress(media),
          thumbnailSize: thumbnailSize,
          thumbnailFormat: thumbnailFormat,
          thumbnailQuality: thumbnailQuality,
          thumbnailScale: thumbnailScale,
        );

        return itemBuilder?.call(
              context,
              mediaList,
              index,
              streamPhotoGalleryTile,
            ) ??
            streamPhotoGalleryTile;
      },
      emptyBuilder: (context) {
        // final chatThemeData = AppCubit.theme(context);
        return emptyBuilder?.call(context) ??
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ScrollViewEmptyWidget(
                  emptyIcon: const Icon(Icons.image),
                  emptyTitle: Text(
                    S.current.khong_co_du_lieu,
                    // style: chatThemeData.textTheme.headline,
                  ),
                ),
              ),
            );
      },
      loadMoreErrorBuilder: (context, error) {
        return ScrollViewLoadMoreError.grid(
          onTap: controller.retry,
          error: Text(
            'Có lỗi xảy ra',
            textAlign: TextAlign.center,
          ),
        );
      },
      loadMoreIndicatorBuilder: (context) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ScrollViewLoadMoreIndicator(),
          ),
        );
      },
      loadingBuilder: (context) {
        return loadingBuilder?.call(context) ??
            const Center(
              child: ScrollViewLoadingWidget(),
            );
      },
      errorBuilder: (
        context,
      ) {
        return errorBuilder?.call(context) ??
            Center(
              child: Text(
                'Có lỗi xảy ra',
              ),
            );
      },
    );
  }
}
