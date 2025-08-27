// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_paging_controller.dart';
import 'package:sba/src/screens/home/controller/dinh_gia_nhanh_controller.dart';
import 'package:sba/src/services/api/fast_valuation_api.dart';
part 'dinhgianhanh_list_item_controller.g.dart';

@riverpod
Future<ApiResponse<List<FastValuationModel>?>> _getListAssets(
  _GetListAssetsRef ref, {
  int? pageIndex,
  required AssetsTypeEnum? assetsType,
}) async {
  return ref.read(fastApiProvider).getListAssets(
        page: pageIndex ?? 1,
        assetType: assetsType,
        instance: FastValuationModel.fromJson,
      );
}

class DinhGiaNhanhListController
    extends PagingValueNotifier<int?, FastValuationModel> {
  static final dinhGiaNhanhListProvider = StateNotifierProvider.autoDispose<
      DinhGiaNhanhListController, PagingValue<int?, FastValuationModel>>(
    (ref) {
      final currentType =
          ref.watch(DinhGiaNhanhController.dinhGiaNhanhProvider).currentType;
      final controller = DinhGiaNhanhListController(
        const PagingValue.loading(),
        ref,
        currentType,
      );
      controller.doInitialLoad();
      return controller;
    },
    name: S.current.dinh_gia_nhanh,
  );

  final AssetsTypeEnum? currentType;

  DinhGiaNhanhListController(
    super.state,
    super.ref,
    this.currentType,
  );

  @override
  Future<void> doInitialLoad() async {
    final result = await ref.read(
      _getListAssetsProvider(
        assetsType: currentType,
      ).future,
    );
    bool isOK = await handleResponse(result, (p0) {
      final data = p0 ?? [];
      state = PagingValue(items: data, nextPageKey: data.isNotEmpty ? 2 : null);
    }, error: (e) {
      state = const PagingValue.error();
    });
  }

  @override
  Future<void> loadMore(int? nextPageKey) async {
    if (nextPageKey == null) return;
    final result = await ref.read(_getListAssetsProvider(
      pageIndex: nextPageKey,
      assetsType: currentType,
    ).future);
    bool isOK = await handleResponse(result, (p0) {
      final data = p0 ?? [];

      appendLastPage(p0 ?? [], data.isNotEmpty ? nextPageKey + 1 : null);
    }, error: (e) {
      appendLastPage([], null);
    });
  }

  void goToDetailPage(BuildContext context, FastValuationModel item) {}

  void deleteAsset(FastValuationModel item, int index) async {
    final newItem = [...state.asSuccess.items]..removeAt(index);
    state = PagingValue(
      items: newItem,
      nextPageKey: state.asSuccess.nextPageKey,
    );
    final result = await ref
        .read(fastApiProvider)
        .xoaTaiSan(iD: item.assetId, assetType: 0);
  }
}
