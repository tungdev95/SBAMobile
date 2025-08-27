import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
part 'base_paging_controller.freezed.dart';

/// Default initial page size multiplier.
const defaultInitialPagedLimitMultiplier = 3;

/// Value listenable for paged data.
typedef PagedValueListenableBuilder<Key, Value>
    = BaseController<PagingValue<Key, Value>>;

abstract class PagingValueNotifier<Key, Value>
    extends BaseController<PagingValue<Key, Value>> {
  PagingValueNotifier(super.state, super.ref);

  /// Returns the currently loaded items
  List<Value> get currentItems => state.asSuccess.items;

  /// Appends [newItems] to the previously loaded ones and sets the next page
  /// key to `null`.
  void appendLastPage(List<Value> newItems, Key nextPageKey) {
    final updatedItems = currentItems + newItems;
    state = PagingValue(items: updatedItems, nextPageKey: nextPageKey);
  }

  /// Retry any failed load requests.
  ///
  /// Unlike [refresh], this does not resets the whole [value],
  /// it only retries the last failed load request.
  Future<void> retry() {
    final lastValue = state.asSuccess;
    assert(lastValue.hasError, '');

    final nextPageKey = lastValue.nextPageKey;
    // resetting the error
    state = lastValue.copyWith(error: null);
    // ignore: null_check_on_nullable_type_parameter
    return loadMore(nextPageKey!);
  }

  /// Refresh the data presented by this [PagingValueNotifier].
  ///
  /// Resets the [value] to the initial value in case [resetValue] is true.
  ///
  /// Note: This API is intended for UI-driven refresh signals,
  /// such as swipe-to-refresh.
  Future<void> refresh({bool resetValue = true}) {
    return doInitialLoad();
  }

  /// Load initial data from the server.
  Future<void> doInitialLoad();

  /// Load more data from the server using [nextPageKey].
  Future<void> loadMore(Key nextPageKey);
}

@freezed
class PagingValue<Key, Value> with _$PagingValue<Key, Value> {
  const factory PagingValue({
    /// List with all items loaded so far.
    required List<Value> items,

    /// The key for the next page to be fetched.
    Key? nextPageKey,

    /// The current error, if any.
    AppException? error,
  }) = Success<Key, Value>;

  const PagingValue._();

  const factory PagingValue.loading() = Loading;

  const factory PagingValue.error() = Error;

  bool get isSuccess => this is Success<Key, Value>;

  /// Returns `true` if the [PagingValue] is not [Success].
  bool get isNotSuccess => !isSuccess;

  /// Returns the [PagingValue] as [Success].
  Success<Key, Value> get asSuccess {
    assert(
      isSuccess,
      'Cannot get asSuccess if the PagedValue is not in the Success state',
    );
    return this as Success<Key, Value>;
  }

  /// Returns `true` if the [PagingValue] is [Success]
  /// and has more items to load.
  bool get hasNextPage => asSuccess.nextPageKey != null;

  /// Returns `true` if the [PagingValue] is [Success] and has an error.
  bool get hasError => asSuccess.error != null;

  ///
  int get itemCount {
    final count = asSuccess.items.length;
    if (hasNextPage || hasError) return count + 1;
    return count;
  }
}
