// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_land_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListCayTrongHash() => r'0eeaf5cf339fada3d03974cff28aad066fd846be';

/// See also [getListCayTrong].
@ProviderFor(getListCayTrong)
final getListCayTrongProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListCayTrong,
  name: r'getListCayTrongProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListCayTrongHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListCayTrongRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getHSPLCTXDHash() => r'5c791201631d2306d71c963854e2222920fcd963';

/// See also [getHSPLCTXD].
@ProviderFor(getHSPLCTXD)
final getHSPLCTXDProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getHSPLCTXD,
  name: r'getHSPLCTXDProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getHSPLCTXDHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetHSPLCTXDRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getTenCTXDHash() => r'e7b317b53f6cbda5fa687a5e3a69c9994a594138';

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

/// See also [getTenCTXD].
@ProviderFor(getTenCTXD)
const getTenCTXDProvider = GetTenCTXDFamily();

/// See also [getTenCTXD].
class GetTenCTXDFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getTenCTXD].
  const GetTenCTXDFamily();

  /// See also [getTenCTXD].
  GetTenCTXDProvider call(
    ConstructionModel construction,
  ) {
    return GetTenCTXDProvider(
      construction,
    );
  }

  @override
  GetTenCTXDProvider getProviderOverride(
    covariant GetTenCTXDProvider provider,
  ) {
    return call(
      provider.construction,
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
  String? get name => r'getTenCTXDProvider';
}

/// See also [getTenCTXD].
class GetTenCTXDProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getTenCTXD].
  GetTenCTXDProvider(
    ConstructionModel construction,
  ) : this._internal(
          (ref) => getTenCTXD(
            ref as GetTenCTXDRef,
            construction,
          ),
          from: getTenCTXDProvider,
          name: r'getTenCTXDProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTenCTXDHash,
          dependencies: GetTenCTXDFamily._dependencies,
          allTransitiveDependencies:
              GetTenCTXDFamily._allTransitiveDependencies,
          construction: construction,
        );

  GetTenCTXDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.construction,
  }) : super.internal();

  final ConstructionModel construction;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetTenCTXDRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTenCTXDProvider._internal(
        (ref) => create(ref as GetTenCTXDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        construction: construction,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetTenCTXDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTenCTXDProvider && other.construction == construction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, construction.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTenCTXDRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `construction` of this provider.
  ConstructionModel get construction;
}

class _GetTenCTXDProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetTenCTXDRef {
  _GetTenCTXDProviderElement(super.provider);

  @override
  ConstructionModel get construction =>
      (origin as GetTenCTXDProvider).construction;
}

String _$getLoaiCTXDHash() => r'ed39ccbe43d3ba864746465367e819219764cd2a';

/// See also [getLoaiCTXD].
@ProviderFor(getLoaiCTXD)
final getLoaiCTXDProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getLoaiCTXD,
  name: r'getLoaiCTXDProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLoaiCTXDHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLoaiCTXDRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getMucDichSuDungSBAHash() =>
    r'829ee57c11e23ee1ee9fa18aac194ece8822a292';

/// See also [getMucDichSuDungSBA].
@ProviderFor(getMucDichSuDungSBA)
final getMucDichSuDungSBAProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getMucDichSuDungSBA,
  name: r'getMucDichSuDungSBAProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMucDichSuDungSBAHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMucDichSuDungSBARef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getDoanDuongTrongKhungGiaHash() =>
    r'3a5bdc6086ceeaaa43c01f43d0ee3161d196b102';

/// See also [getDoanDuongTrongKhungGia].
@ProviderFor(getDoanDuongTrongKhungGia)
const getDoanDuongTrongKhungGiaProvider = GetDoanDuongTrongKhungGiaFamily();

/// See also [getDoanDuongTrongKhungGia].
class GetDoanDuongTrongKhungGiaFamily
    extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getDoanDuongTrongKhungGia].
  const GetDoanDuongTrongKhungGiaFamily();

  /// See also [getDoanDuongTrongKhungGia].
  GetDoanDuongTrongKhungGiaProvider call(
    AssetLandInfo landInfo,
  ) {
    return GetDoanDuongTrongKhungGiaProvider(
      landInfo,
    );
  }

  @override
  GetDoanDuongTrongKhungGiaProvider getProviderOverride(
    covariant GetDoanDuongTrongKhungGiaProvider provider,
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
  String? get name => r'getDoanDuongTrongKhungGiaProvider';
}

/// See also [getDoanDuongTrongKhungGia].
class GetDoanDuongTrongKhungGiaProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getDoanDuongTrongKhungGia].
  GetDoanDuongTrongKhungGiaProvider(
    AssetLandInfo landInfo,
  ) : this._internal(
          (ref) => getDoanDuongTrongKhungGia(
            ref as GetDoanDuongTrongKhungGiaRef,
            landInfo,
          ),
          from: getDoanDuongTrongKhungGiaProvider,
          name: r'getDoanDuongTrongKhungGiaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDoanDuongTrongKhungGiaHash,
          dependencies: GetDoanDuongTrongKhungGiaFamily._dependencies,
          allTransitiveDependencies:
              GetDoanDuongTrongKhungGiaFamily._allTransitiveDependencies,
          landInfo: landInfo,
        );

  GetDoanDuongTrongKhungGiaProvider._internal(
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
    FutureOr<List<KeyValueModel>> Function(
            GetDoanDuongTrongKhungGiaRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDoanDuongTrongKhungGiaProvider._internal(
        (ref) => create(ref as GetDoanDuongTrongKhungGiaRef),
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
    return _GetDoanDuongTrongKhungGiaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDoanDuongTrongKhungGiaProvider &&
        other.landInfo == landInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, landInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDoanDuongTrongKhungGiaRef
    on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `landInfo` of this provider.
  AssetLandInfo get landInfo;
}

class _GetDoanDuongTrongKhungGiaProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetDoanDuongTrongKhungGiaRef {
  _GetDoanDuongTrongKhungGiaProviderElement(super.provider);

  @override
  AssetLandInfo get landInfo =>
      (origin as GetDoanDuongTrongKhungGiaProvider).landInfo;
}

String _$getListDistrictHash() => r'607fb377d32419ad6c9253db9989f43420d108a7';

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

String _$getListAddressHash() => r'3733a66461898353b37af745ea454959f5d97075';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
