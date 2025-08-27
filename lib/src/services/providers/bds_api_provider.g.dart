// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bds_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListAddressHash() => r'75cfc65f90e95973b691026da086d7b2bfc44eb3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getListAddress].
@ProviderFor(getListAddress)
const getListAddressProvider = GetListAddressFamily();

/// See also [getListAddress].
class GetListAddressFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListAddress].
  const GetListAddressFamily();

  /// See also [getListAddress].
  GetListAddressProvider call(
    AssetLandInfo landInfo,
  ) {
    return GetListAddressProvider(
      landInfo,
    );
  }

  @override
  GetListAddressProvider getProviderOverride(
    covariant GetListAddressProvider provider,
  ) {
    return call(
      provider.landInfo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getListAddressProvider';
}

/// See also [getListAddress].
class GetListAddressProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListAddress].
  GetListAddressProvider(
    AssetLandInfo landInfo,
  ) : this._internal(
          (ref) => getListAddress(
            ref as GetListAddressRef,
            landInfo,
          ),
          from: getListAddressProvider,
          name: r'getListAddressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListAddressHash,
          dependencies: GetListAddressFamily._dependencies,
          allTransitiveDependencies:
              GetListAddressFamily._allTransitiveDependencies,
          landInfo: landInfo,
        );

  GetListAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.landInfo,
  }) : super.internal();

  final AssetLandInfo landInfo;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListAddressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListAddressProvider._internal(
        (ref) => create(ref as GetListAddressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        landInfo: landInfo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListAddressProvider && other.landInfo == landInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, landInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListAddressRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `landInfo` of this provider.
  AssetLandInfo get landInfo;
}

class _GetListAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListAddressRef {
  _GetListAddressProviderElement(super.provider);

  @override
  AssetLandInfo get landInfo => (origin as GetListAddressProvider).landInfo;
}

String _$getListDistrictHash() => r'6a000235d2bf8fcc7d987543350f4f24864dd22b';

/// See also [getListDistrict].
@ProviderFor(getListDistrict)
const getListDistrictProvider = GetListDistrictFamily();

/// See also [getListDistrict].
class GetListDistrictFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDistrict].
  const GetListDistrictFamily();

  /// See also [getListDistrict].
  GetListDistrictProvider call(
    AssetLandInfo landInfo,
  ) {
    return GetListDistrictProvider(
      landInfo,
    );
  }

  @override
  GetListDistrictProvider getProviderOverride(
    covariant GetListDistrictProvider provider,
  ) {
    return call(
      provider.landInfo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getListDistrictProvider';
}

/// See also [getListDistrict].
class GetListDistrictProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListDistrict].
  GetListDistrictProvider(
    AssetLandInfo landInfo,
  ) : this._internal(
          (ref) => getListDistrict(
            ref as GetListDistrictRef,
            landInfo,
          ),
          from: getListDistrictProvider,
          name: r'getListDistrictProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListDistrictHash,
          dependencies: GetListDistrictFamily._dependencies,
          allTransitiveDependencies:
              GetListDistrictFamily._allTransitiveDependencies,
          landInfo: landInfo,
        );

  GetListDistrictProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.landInfo,
  }) : super.internal();

  final AssetLandInfo landInfo;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListDistrictRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListDistrictProvider._internal(
        (ref) => create(ref as GetListDistrictRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        landInfo: landInfo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListDistrictProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListDistrictProvider && other.landInfo == landInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, landInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListDistrictRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `landInfo` of this provider.
  AssetLandInfo get landInfo;
}

class _GetListDistrictProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDistrictRef {
  _GetListDistrictProviderElement(super.provider);

  @override
  AssetLandInfo get landInfo => (origin as GetListDistrictProvider).landInfo;
}

String _$getPositionHash() => r'203a064c58dae5babf6567a6084b59c3693f77a5';

/// See also [getPosition].
@ProviderFor(getPosition)
final getPositionProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getPosition,
  name: r'getPositionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPositionRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getViTriTrongKhungGiaHash() =>
    r'b39385359f8b59e4fc6f4ddeb0b25091d29c746a';

/// See also [getViTriTrongKhungGia].
@ProviderFor(getViTriTrongKhungGia)
final getViTriTrongKhungGiaProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getViTriTrongKhungGia,
  name: r'getViTriTrongKhungGiaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getViTriTrongKhungGiaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetViTriTrongKhungGiaRef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getZoneHash() => r'34238ad1cf959f01aa41aabe90061f9533844312';

/// See also [getZone].
@ProviderFor(getZone)
final getZoneProvider = AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getZone,
  name: r'getZoneProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getZoneHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetZoneRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getLoaiDuongTiepGiapHash() =>
    r'693d0486668a4f40408f0386c7205873208ba7ac';

/// See also [getLoaiDuongTiepGiap].
@ProviderFor(getLoaiDuongTiepGiap)
final getLoaiDuongTiepGiapProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getLoaiDuongTiepGiap,
  name: r'getLoaiDuongTiepGiapProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLoaiDuongTiepGiapHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLoaiDuongTiepGiapRef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
