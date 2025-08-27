// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thuadat_duan_detail_page_controller.dart';

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
String _$getDacTinhKyThuatHash() => r'7641dd5cbba8d009d4afde631fdb1641414f3882';

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

/// See also [getDacTinhKyThuat].
@ProviderFor(getDacTinhKyThuat)
const getDacTinhKyThuatProvider = GetDacTinhKyThuatFamily();

/// See also [getDacTinhKyThuat].
class GetDacTinhKyThuatFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getDacTinhKyThuat].
  const GetDacTinhKyThuatFamily();

  /// See also [getDacTinhKyThuat].
  GetDacTinhKyThuatProvider call(
    ConstructionModel construction,
  ) {
    return GetDacTinhKyThuatProvider(
      construction,
    );
  }

  @override
  GetDacTinhKyThuatProvider getProviderOverride(
    covariant GetDacTinhKyThuatProvider provider,
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
  String? get name => r'getDacTinhKyThuatProvider';
}

/// See also [getDacTinhKyThuat].
class GetDacTinhKyThuatProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getDacTinhKyThuat].
  GetDacTinhKyThuatProvider(
    ConstructionModel construction,
  ) : this._internal(
          (ref) => getDacTinhKyThuat(
            ref as GetDacTinhKyThuatRef,
            construction,
          ),
          from: getDacTinhKyThuatProvider,
          name: r'getDacTinhKyThuatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDacTinhKyThuatHash,
          dependencies: GetDacTinhKyThuatFamily._dependencies,
          allTransitiveDependencies:
              GetDacTinhKyThuatFamily._allTransitiveDependencies,
          construction: construction,
        );

  GetDacTinhKyThuatProvider._internal(
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
    FutureOr<List<KeyValueModel>> Function(GetDacTinhKyThuatRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDacTinhKyThuatProvider._internal(
        (ref) => create(ref as GetDacTinhKyThuatRef),
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
    return _GetDacTinhKyThuatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDacTinhKyThuatProvider &&
        other.construction == construction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, construction.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDacTinhKyThuatRef
    on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `construction` of this provider.
  ConstructionModel get construction;
}

class _GetDacTinhKyThuatProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetDacTinhKyThuatRef {
  _GetDacTinhKyThuatProviderElement(super.provider);

  @override
  ConstructionModel get construction =>
      (origin as GetDacTinhKyThuatProvider).construction;
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
    r'5a21b6241bb4db2dcb395b6b469982cbfebc12e1';

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
    AssetLandInfo info,
  ) {
    return GetDoanDuongTrongKhungGiaProvider(
      info,
    );
  }

  @override
  GetDoanDuongTrongKhungGiaProvider getProviderOverride(
    covariant GetDoanDuongTrongKhungGiaProvider provider,
  ) {
    return call(
      provider.info,
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
    AssetLandInfo info,
  ) : this._internal(
          (ref) => getDoanDuongTrongKhungGia(
            ref as GetDoanDuongTrongKhungGiaRef,
            info,
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
          info: info,
        );

  GetDoanDuongTrongKhungGiaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.info,
  }) : super.internal();

  final AssetLandInfo info;

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
        info: info,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetDoanDuongTrongKhungGiaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDoanDuongTrongKhungGiaProvider && other.info == info;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, info.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDoanDuongTrongKhungGiaRef
    on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `info` of this provider.
  AssetLandInfo get info;
}

class _GetDoanDuongTrongKhungGiaProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetDoanDuongTrongKhungGiaRef {
  _GetDoanDuongTrongKhungGiaProviderElement(super.provider);

  @override
  AssetLandInfo get info => (origin as GetDoanDuongTrongKhungGiaProvider).info;
}

String _$getListDistrictHash() => r'6ff8c966df576d62bb0248e44cd85494adcb8b4a';

/// See also [getListDistrict].
@ProviderFor(getListDistrict)
const getListDistrictProvider = GetListDistrictFamily();

/// See also [getListDistrict].
class GetListDistrictFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDistrict].
  const GetListDistrictFamily();

  /// See also [getListDistrict].
  GetListDistrictProvider call(
    AssetLandInfo info,
  ) {
    return GetListDistrictProvider(
      info,
    );
  }

  @override
  GetListDistrictProvider getProviderOverride(
    covariant GetListDistrictProvider provider,
  ) {
    return call(
      provider.info,
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
    AssetLandInfo info,
  ) : this._internal(
          (ref) => getListDistrict(
            ref as GetListDistrictRef,
            info,
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
          info: info,
        );

  GetListDistrictProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.info,
  }) : super.internal();

  final AssetLandInfo info;

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
        info: info,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListDistrictProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListDistrictProvider && other.info == info;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, info.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListDistrictRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `info` of this provider.
  AssetLandInfo get info;
}

class _GetListDistrictProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDistrictRef {
  _GetListDistrictProviderElement(super.provider);

  @override
  AssetLandInfo get info => (origin as GetListDistrictProvider).info;
}

String _$getListAddressHash() => r'15fa5a81e0b71cda09bf6b46fdeb54bf269e8ef6';

/// See also [getListAddress].
@ProviderFor(getListAddress)
const getListAddressProvider = GetListAddressFamily();

/// See also [getListAddress].
class GetListAddressFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListAddress].
  const GetListAddressFamily();

  /// See also [getListAddress].
  GetListAddressProvider call(
    AssetLandInfo info,
  ) {
    return GetListAddressProvider(
      info,
    );
  }

  @override
  GetListAddressProvider getProviderOverride(
    covariant GetListAddressProvider provider,
  ) {
    return call(
      provider.info,
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
    AssetLandInfo info,
  ) : this._internal(
          (ref) => getListAddress(
            ref as GetListAddressRef,
            info,
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
          info: info,
        );

  GetListAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.info,
  }) : super.internal();

  final AssetLandInfo info;

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
        info: info,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListAddressProvider && other.info == info;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, info.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListAddressRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `info` of this provider.
  AssetLandInfo get info;
}

class _GetListAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListAddressRef {
  _GetListAddressProviderElement(super.provider);

  @override
  AssetLandInfo get info => (origin as GetListAddressProvider).info;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
