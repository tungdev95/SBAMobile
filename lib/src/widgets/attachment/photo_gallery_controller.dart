import 'package:collection/collection.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/widgets/base/paged_value_notifier.dart';

///
class PhotoGalleryController extends PagedValueNotifier<int, AssetEntity> {
  ///
  PhotoGalleryController({
    this.limit = 50,
  }) : super(const PagedValue.loading());

  /// The maximum number of items to load at once.
  final int limit;

  Future<AssetPathEntity?> _getRecentAssetPathList({
    RequestType type = RequestType.image,
    FilterOptionGroup? filterOption,
  }) {
    return PhotoManager.getAssetPathList(
      type: type,
      onlyAll: true,
      filterOption: filterOption,
    ).then((it) {
      return it.firstOrNull;
    });
  }

  @override
  Future<void> doInitialLoad() async {
    try {
      final assets = await _getRecentAssetPathList();

      if (assets == null) {
        value = const PagedValue(items: []);
        return;
      }

      final mediaList = await assets.getAssetListPaged(
        page: 0,
        size: limit,
      );

      final nextKey = mediaList.length < limit ? null : 1;
      value = PagedValue(
        items: mediaList,
        nextPageKey: nextKey,
      );
    } on AppException catch (error) {
      value = PagedValue.error(error);
    } catch (error) {
      final chatError = AppException(error.toString());
      value = PagedValue.error(chatError);
    }
  }

  @override
  Future<void> loadMore(int page) async {
    final previousValue = value.asSuccess;

    try {
      final assets = await _getRecentAssetPathList();

      if (assets == null) {
        final error = AppException('No media found');
        value = previousValue.copyWith(error: error);
        return;
      }

      final mediaList = await assets.getAssetListPaged(
        page: page,
        size: limit,
      );

      final previousItems = previousValue.items;
      final newItems = previousItems + mediaList;
      final nextKey = mediaList.length < limit ? null : page + 1;
      value = PagedValue(
        items: newItems,
        nextPageKey: nextKey,
      );
    } on AppException catch (error) {
      value = previousValue.copyWith(error: error);
    } catch (error) {
      final appError = AppException(error.toString());
      value = previousValue.copyWith(error: appError);
    }
  }
}
