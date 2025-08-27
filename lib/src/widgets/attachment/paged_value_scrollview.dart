import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/widgets/base/paged_value_notifier.dart';

typedef PagedValueScrollViewIndexedWidgetBuilder<T> = Widget Function(
  BuildContext context,
  List<T> values,
  int index,
);

typedef PagedValueScrollViewLoadMoreErrorBuilder = Widget Function(
  BuildContext context,
  AppException error,
);

class PagedValueListView<K, V> extends StatefulWidget {
  /// Creates a new instance of [PagedValueListView] widget.
  const PagedValueListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.emptyBuilder,
    this.loadMoreErrorBuilder,
    this.loadMoreIndicatorBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.loadMoreTriggerIndex = 3,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.shrinkWrap = false,
    this.padding,
  });

  final PagedValueNotifier<K, V> controller;

  final PagedValueScrollViewIndexedWidgetBuilder<V> itemBuilder;

  final PagedValueScrollViewIndexedWidgetBuilder<V> separatorBuilder;

  final WidgetBuilder? emptyBuilder;

  /// A builder that is called to build the load more error state of the list.
  final PagedValueScrollViewLoadMoreErrorBuilder? loadMoreErrorBuilder;

  /// A builder that is called to build the load more indicator of the list.
  final WidgetBuilder? loadMoreIndicatorBuilder;

  /// A builder that is called to build the loading state of the list.
  final WidgetBuilder? loadingBuilder;

  /// A builder that is called to build the error state of the list.
  final Widget Function(BuildContext)? errorBuilder;

  /// The index to take into account when triggering [controller.loadMore].
  final int loadMoreTriggerIndex;

  final Axis scrollDirection;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  final ScrollController? scrollController;

  final bool shrinkWrap;

  @override
  State<PagedValueListView<K, V>> createState() =>
      _PagedValueListViewState<K, V>();
}

class _PagedValueListViewState<K, V> extends State<PagedValueListView<K, V>> {
  PagedValueNotifier<K, V> get _controller => widget.controller;

  // Avoids duplicate requests on rebuilds.
  bool _hasRequestedNextPage = false;

  @override
  void initState() {
    super.initState();
    _controller.init();
    _controller.doInitialLoad();
  }

  @override
  void didUpdateWidget(covariant PagedValueListView<K, V> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller != oldWidget.controller) {
      // reset duplicate requests flag
      _hasRequestedNextPage = false;
      _controller.doInitialLoad();
    }
  }

  @override
  Widget build(BuildContext context) => PagedValueListenableBuilder<K, V>(
        valueListenable: _controller,
        builder: (context, value, _) => value.when(
          (items, nextPageKey, error) {
            if (items.isEmpty) {
              return widget.emptyBuilder?.call(context) ?? emptyWidget(context);
            }

            return RefreshIndicator.adaptive(
              onRefresh: () {
                return _controller.refresh(resetValue: false);
              },
              child: ListView.separated(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                controller: widget.scrollController,
                shrinkWrap: widget.shrinkWrap,
                itemCount: value.itemCount,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                separatorBuilder: (context, index) =>
                    widget.separatorBuilder(context, items, index),
                itemBuilder: (context, index) {
                  if (!_hasRequestedNextPage) {
                    final newPageRequestTriggerIndex =
                        items.length - widget.loadMoreTriggerIndex;
                    final isBuildingTriggerIndexItem =
                        index == newPageRequestTriggerIndex;
                    if (nextPageKey != null && isBuildingTriggerIndexItem) {
                      // Schedules the request for the end of this frame.
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        if (error == null) {
                          await _controller.loadMore(nextPageKey);
                        }
                        _hasRequestedNextPage = false;
                      });
                      _hasRequestedNextPage = true;
                    }
                  }

                  if (index == items.length) {
                    if (error != null) {
                      return widget.loadMoreErrorBuilder
                              ?.call(context, error) ??
                          const SizedBox.shrink();
                    } else if (items.length <= widget.loadMoreTriggerIndex) {
                      return const SizedBox.shrink();
                    }
                    return widget.loadMoreIndicatorBuilder?.call(context) ??
                        loadingMoreWidget(context);
                  }

                  return widget.itemBuilder(context, items, index);
                },
              ),
            );
          },
          loading: () =>
              widget.loadingBuilder?.call(context) ?? loadingWidget(context),
          error: (error) =>
              widget.errorBuilder?.call(context) ?? errorWidget(context),
        ),
      );

  Widget loadingWidget(BuildContext context) {
    return const LoadingWidget();
  }

  Widget loadingMoreWidget(BuildContext context) {
    return const CupertinoActivityIndicator();
  }

  Widget errorWidget(BuildContext context) {
    return const Text(
      'Có lỗi xảy ra, vui lòng thử lại sau',
    );
  }

  Widget emptyWidget(BuildContext context) {
    return const Text(
      'Không có dữ liệu',
      style: TextStyle(color: Colors.black),
    );
  }
}

/// A [GridView] that loads more pages when the user scrolls to the end of the
/// grid.
///
/// Use [loadMoreTriggerIndex] to set the index of the item that triggers the
/// loading of the next page.
class PagedValueGridView<K, V> extends StatefulWidget {
  /// Creates a new instance of [PagedValueGridView] widget.
  const PagedValueGridView({
    super.key,
    required this.controller,
    required this.gridDelegate,
    required this.itemBuilder,
    required this.emptyBuilder,
    required this.loadMoreErrorBuilder,
    required this.loadMoreIndicatorBuilder,
    required this.loadingBuilder,
    required this.errorBuilder,
    this.shrinkWrap = false,
    this.loadMoreTriggerIndex = 3,
    this.scrollController,
    this.padding,
  });

  /// The [PagedValueNotifier] used to control the list of items.
  final PagedValueNotifier<K, V> controller;

  /// A delegate that controls the layout of the children within
  /// the [PagedValueGridView].
  final SliverGridDelegate gridDelegate;

  /// A builder that is called to build items in the [PagedValueGridView].
  ///
  /// The `value` parameter is the [V] at this position in the list.
  final PagedValueScrollViewIndexedWidgetBuilder<V> itemBuilder;

  /// A builder that is called to build the empty state of the list.
  final WidgetBuilder emptyBuilder;

  /// A builder that is called to build the load more error state of the list.
  final PagedValueScrollViewLoadMoreErrorBuilder loadMoreErrorBuilder;

  /// A builder that is called to build the load more indicator of the list.
  final WidgetBuilder loadMoreIndicatorBuilder;

  /// A builder that is called to build the loading state of the list.
  final WidgetBuilder loadingBuilder;

  /// A builder that is called to build the error state of the list.
  final Widget Function(BuildContext) errorBuilder;

  /// The index to take into account when triggering [controller.loadMore].
  final int loadMoreTriggerIndex;

  final ScrollController? scrollController;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  @override
  State<PagedValueGridView<K, V>> createState() =>
      _PagedValueGridViewState<K, V>();
}

class _PagedValueGridViewState<K, V> extends State<PagedValueGridView<K, V>> {
  PagedValueNotifier<K, V> get _controller => widget.controller;

  // Avoids duplicate requests on rebuilds.
  bool _hasRequestedNextPage = false;

  @override
  void initState() {
    super.initState();
    _controller.doInitialLoad();
  }

  @override
  void didUpdateWidget(covariant PagedValueGridView<K, V> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller != oldWidget.controller) {
      // reset duplicate requests flag
      _hasRequestedNextPage = false;
      _controller.doInitialLoad();
    }
  }

  @override
  Widget build(BuildContext context) => PagedValueListenableBuilder<K, V>(
        valueListenable: _controller,
        builder: (context, value, _) => value.when(
          (items, nextPageKey, error) {
            if (items.isEmpty) {
              return widget.emptyBuilder(context);
            }

            return GridView.builder(
              controller: widget.scrollController,
              padding: widget.padding,
              itemCount: value.itemCount,
              gridDelegate: widget.gridDelegate,
              itemBuilder: (context, index) {
                if (!_hasRequestedNextPage) {
                  final newPageRequestTriggerIndex =
                      items.length - widget.loadMoreTriggerIndex;
                  final isBuildingTriggerIndexItem =
                      index == newPageRequestTriggerIndex;
                  if (nextPageKey != null && isBuildingTriggerIndexItem) {
                    // Schedules the request for the end of this frame.
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      if (error == null) {
                        await _controller.loadMore(nextPageKey);
                      }
                      _hasRequestedNextPage = false;
                    });
                    _hasRequestedNextPage = true;
                  }
                }

                if (index == items.length) {
                  if (error != null) {
                    return widget.loadMoreErrorBuilder(context, error);
                  }
                  return widget.loadMoreIndicatorBuilder(context);
                }

                return widget.itemBuilder(context, items, index);
              },
            );
          },
          loading: () => widget.loadingBuilder(context),
          error: (error) => widget.errorBuilder(context),
        ),
      );
}
