// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dinhgianhanh_bds_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$getDacTinhKyThuatHash() => r'9ff8347fac5c421a3d526e59ba7eb4b682c0695d';

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
    FastValueConstruction value,
  ) {
    return GetDacTinhKyThuatProvider(
      value,
    );
  }

  @override
  GetDacTinhKyThuatProvider getProviderOverride(
    covariant GetDacTinhKyThuatProvider provider,
  ) {
    return call(
      provider.value,
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
    FastValueConstruction value,
  ) : this._internal(
          (ref) => getDacTinhKyThuat(
            ref as GetDacTinhKyThuatRef,
            value,
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
          value: value,
        );

  GetDacTinhKyThuatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
  }) : super.internal();

  final FastValueConstruction value;

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
        value: value,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetDacTinhKyThuatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDacTinhKyThuatProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDacTinhKyThuatRef
    on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `value` of this provider.
  FastValueConstruction get value;
}

class _GetDacTinhKyThuatProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetDacTinhKyThuatRef {
  _GetDacTinhKyThuatProviderElement(super.provider);

  @override
  FastValueConstruction get value =>
      (origin as GetDacTinhKyThuatProvider).value;
}

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
String _$getListPositionHash() => r'aa3283d9567b0f95b94f1894fc421cce6f65dfed';

/// See also [getListPosition].
@ProviderFor(getListPosition)
final getListPositionProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListPosition,
  name: r'getListPositionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListPositionRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getDoanDuongTrongKhungGiaHash() =>
    r'6bfca4b48315af1d01dc211fff4ce5f1586922ba';

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
    FastValuationModel landInfo,
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
    FastValuationModel landInfo,
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

  final FastValuationModel landInfo;

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
  FastValuationModel get landInfo;
}

class _GetDoanDuongTrongKhungGiaProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetDoanDuongTrongKhungGiaRef {
  _GetDoanDuongTrongKhungGiaProviderElement(super.provider);

  @override
  FastValuationModel get landInfo =>
      (origin as GetDoanDuongTrongKhungGiaProvider).landInfo;
}

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
String _$getListProvinceHash() => r'dd3e0f03209db29b81b5bfb2caaea1c02c643d1a';

/// See also [getListProvince].
@ProviderFor(getListProvince)
final getListProvinceProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListProvince,
  name: r'getListProvinceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListProvinceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListProvinceRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getListDistrictHash() => r'c32ced1c6a4bf2a1c93b86c68e33ba9b5c9737d4';

/// See also [getListDistrict].
@ProviderFor(getListDistrict)
const getListDistrictProvider = GetListDistrictFamily();

/// See also [getListDistrict].
class GetListDistrictFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDistrict].
  const GetListDistrictFamily();

  /// See also [getListDistrict].
  GetListDistrictProvider call(
    FastValuationModel landInfo,
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
    FastValuationModel landInfo,
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

  final FastValuationModel landInfo;

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
  FastValuationModel get landInfo;
}

class _GetListDistrictProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDistrictRef {
  _GetListDistrictProviderElement(super.provider);

  @override
  FastValuationModel get landInfo =>
      (origin as GetListDistrictProvider).landInfo;
}

String _$getListAddressHash() => r'67a962baa83c3b9762adbe91a56fde51d911dd3a';

/// See also [getListAddress].
@ProviderFor(getListAddress)
const getListAddressProvider = GetListAddressFamily();

/// See also [getListAddress].
class GetListAddressFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListAddress].
  const GetListAddressFamily();

  /// See also [getListAddress].
  GetListAddressProvider call(
    FastValuationModel landInfo,
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
    FastValuationModel landInfo,
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

  final FastValuationModel landInfo;

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
  FastValuationModel get landInfo;
}

class _GetListAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListAddressRef {
  _GetListAddressProviderElement(super.provider);

  @override
  FastValuationModel get landInfo =>
      (origin as GetListAddressProvider).landInfo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
