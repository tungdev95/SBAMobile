import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/services/api/assets_api.dart';

part 'bds_api_provider.g.dart';

@riverpod
Future<List<KeyValueModel>> getListAddress(
  GetListAddressRef ref,
  AssetLandInfo landInfo,
) async {
  final districtSelected = ref.watch(selectedDistrictProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(
      selectedDistrictProvider(landInfo),
      (previous, next) {
        keepAliveLink.close();
      },
    );
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListDistrict(
  GetListDistrictRef ref,
  AssetLandInfo landInfo,
) async {
  final provinceSelected = ref.watch(selectedProvinceProvider(landInfo));
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected?.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(selectedProvinceProvider(landInfo), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getPosition(GetPositionRef ref) async {
  final result = await ref.read(assetsApiProvider).getPositions();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getViTriTrongKhungGia(
    GetViTriTrongKhungGiaRef ref) async {
  final result = await ref.read(assetsApiProvider).getPositionInPriceRanges();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getZone(GetZoneRef ref) async {
  final result = await ref.read(assetsApiProvider).getZone();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getLoaiDuongTiepGiap(
    GetLoaiDuongTiepGiapRef ref) async {
  final result = await ref.read(assetsApiProvider).getLoaiDuongTiepGiap();
  if (result.data?.isNotEmpty == true) {
    final keepAlive = ref.keepAlive();
  }
  return result.data ?? [];
}

//Selected Tỉnh
final selectedProvinceProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressProvince = next?.key;
      if (previous == null && next != null) return;

      params.realAddressDistrict = null;
      ref.read(selectedDistrictProvider(params).notifier).state = null;
    });
    if (params.realAddressProvince == null) return null;

    return KeyValueModel(key: params.realAddressProvince, title: null);
  },
);

//Selected Phường xã
final selectedDistrictProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressDistrict = next?.key;
      if (previous == null && next != null) return;
      params.realAddressWard = null;
      ref.read(selectedAddressProvider(params).notifier).state = null;
    });
    if (params.realAddressDistrict == null) return null;

    return KeyValueModel(key: params.realAddressDistrict, title: null);
  },
);

//Selected Quận huyện
final selectedAddressProvider =
    StateProvider.family<KeyValueModel?, AssetLandInfo>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.realAddressWard = next?.key;
    });
    if (params.realAddressWard == null) return null;

    return KeyValueModel(key: params.realAddressWard, title: null);
  },
);
