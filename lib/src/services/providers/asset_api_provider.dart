import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/services/api/assets_api.dart';

part 'asset_api_provider.g.dart';

@riverpod
Future<List<KeyValueModel>> getListLegals(
    GetListLegalsRef ref, int? assetLevel2Id) async {
  final result = await ref.read(assetsApiProvider).getListLegals(assetLevel2Id);
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getLoiTheKinhDoanh(
    GetLoiTheKinhDoanhRef ref) async {
  final result = await ref.read(assetsApiProvider).getBusinessAdvantages();
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getTinhThanhKhoan(GetTinhThanhKhoanRef ref) async {
  final result = await ref.read(assetsApiProvider).getLiqudTies();
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getCBRR(GetTinhThanhKhoanRef ref) async {
  final result = await ref.read(assetsApiProvider).getRiskTypes();
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getCBRRContent(
    GetTinhThanhKhoanRef ref, int assetLevel2Id) async {
  final result = await ref
      .read(assetsApiProvider)
      .getRiskContent(assetLevel2Id: assetLevel2Id);
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListProvince(
  GetListProvinceRef ref,
) async {
  final result = await ref.read(assetsApiProvider).getListProvince();
  if ((result.data ?? []).isNotEmpty) {
    ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListCountry(
  GetListCountryRef ref,
) async {
  final result = await ref.read(assetsApiProvider).country();
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListWheelFomula(
  GetListWheelFomulaRef ref,
) async {
  final result = await ref.read(assetsApiProvider).wheelFomula();
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListGearBox(
  GetListGearBoxRef ref,
) async {
  final result = await ref.read(assetsApiProvider).gearBox();
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getListFuels(
  GetListFuelsRef ref,
) async {
  final result = await ref.read(assetsApiProvider).fuels();
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> getVehicleBrands(
  GetListFuelsRef ref,
  VehicleTypeEnum type,
) async {
  final result = await ref.read(assetsApiProvider).vehicleBrands(type: type);
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
  }
  return result.data ?? [];
}
