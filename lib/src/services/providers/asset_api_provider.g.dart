// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_api_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListLegalsHash() => r'74323a8d61e9437d944d9ebc37fc1a79abcf9e19';

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

/// See also [getListLegals].
@ProviderFor(getListLegals)
const getListLegalsProvider = GetListLegalsFamily();

/// See also [getListLegals].
class GetListLegalsFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListLegals].
  const GetListLegalsFamily();

  /// See also [getListLegals].
  GetListLegalsProvider call(
    int? assetLevel2Id,
  ) {
    return GetListLegalsProvider(
      assetLevel2Id,
    );
  }

  @override
  GetListLegalsProvider getProviderOverride(
    covariant GetListLegalsProvider provider,
  ) {
    return call(
      provider.assetLevel2Id,
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
  String? get name => r'getListLegalsProvider';
}

/// See also [getListLegals].
class GetListLegalsProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListLegals].
  GetListLegalsProvider(
    int? assetLevel2Id,
  ) : this._internal(
          (ref) => getListLegals(
            ref as GetListLegalsRef,
            assetLevel2Id,
          ),
          from: getListLegalsProvider,
          name: r'getListLegalsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListLegalsHash,
          dependencies: GetListLegalsFamily._dependencies,
          allTransitiveDependencies:
              GetListLegalsFamily._allTransitiveDependencies,
          assetLevel2Id: assetLevel2Id,
        );

  GetListLegalsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetLevel2Id,
  }) : super.internal();

  final int? assetLevel2Id;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListLegalsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListLegalsProvider._internal(
        (ref) => create(ref as GetListLegalsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetLevel2Id: assetLevel2Id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListLegalsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListLegalsProvider &&
        other.assetLevel2Id == assetLevel2Id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetLevel2Id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListLegalsRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `assetLevel2Id` of this provider.
  int? get assetLevel2Id;
}

class _GetListLegalsProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListLegalsRef {
  _GetListLegalsProviderElement(super.provider);

  @override
  int? get assetLevel2Id => (origin as GetListLegalsProvider).assetLevel2Id;
}

String _$getLoiTheKinhDoanhHash() =>
    r'91fbaecf9133c3ac956faee5e5cd8cee0b0d02b2';

/// See also [getLoiTheKinhDoanh].
@ProviderFor(getLoiTheKinhDoanh)
final getLoiTheKinhDoanhProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getLoiTheKinhDoanh,
  name: r'getLoiTheKinhDoanhProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLoiTheKinhDoanhHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLoiTheKinhDoanhRef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getTinhThanhKhoanHash() => r'3c5d0101f569161b1d41e4cdb9a2cf365bdb519e';

/// See also [getTinhThanhKhoan].
@ProviderFor(getTinhThanhKhoan)
final getTinhThanhKhoanProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getTinhThanhKhoan,
  name: r'getTinhThanhKhoanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTinhThanhKhoanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetTinhThanhKhoanRef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getCBRRHash() => r'a3729e649397ae8169864a967a046c7a4cc2ce78';

/// See also [getCBRR].
@ProviderFor(getCBRR)
final getCBRRProvider = AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getCBRR,
  name: r'getCBRRProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getCBRRHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCBRRRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getCBRRContentHash() => r'0b2be9d3d4b6d6476b8ec70ec142c9737a1cfd29';

/// See also [getCBRRContent].
@ProviderFor(getCBRRContent)
const getCBRRContentProvider = GetCBRRContentFamily();

/// See also [getCBRRContent].
class GetCBRRContentFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getCBRRContent].
  const GetCBRRContentFamily();

  /// See also [getCBRRContent].
  GetCBRRContentProvider call(
    int assetLevel2Id,
  ) {
    return GetCBRRContentProvider(
      assetLevel2Id,
    );
  }

  @override
  GetCBRRContentProvider getProviderOverride(
    covariant GetCBRRContentProvider provider,
  ) {
    return call(
      provider.assetLevel2Id,
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
  String? get name => r'getCBRRContentProvider';
}

/// See also [getCBRRContent].
class GetCBRRContentProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getCBRRContent].
  GetCBRRContentProvider(
    int assetLevel2Id,
  ) : this._internal(
          (ref) => getCBRRContent(
            ref as GetCBRRContentRef,
            assetLevel2Id,
          ),
          from: getCBRRContentProvider,
          name: r'getCBRRContentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCBRRContentHash,
          dependencies: GetCBRRContentFamily._dependencies,
          allTransitiveDependencies:
              GetCBRRContentFamily._allTransitiveDependencies,
          assetLevel2Id: assetLevel2Id,
        );

  GetCBRRContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetLevel2Id,
  }) : super.internal();

  final int assetLevel2Id;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetCBRRContentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCBRRContentProvider._internal(
        (ref) => create(ref as GetCBRRContentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetLevel2Id: assetLevel2Id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetCBRRContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCBRRContentProvider &&
        other.assetLevel2Id == assetLevel2Id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetLevel2Id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCBRRContentRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `assetLevel2Id` of this provider.
  int get assetLevel2Id;
}

class _GetCBRRContentProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetCBRRContentRef {
  _GetCBRRContentProviderElement(super.provider);

  @override
  int get assetLevel2Id => (origin as GetCBRRContentProvider).assetLevel2Id;
}

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
String _$getListCountryHash() => r'0ad7d385bd50654e93e69c25423bd017fb4e0b2a';

/// See also [getListCountry].
@ProviderFor(getListCountry)
final getListCountryProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListCountry,
  name: r'getListCountryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListCountryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListCountryRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getListWheelFomulaHash() =>
    r'ec799c084b65d3f339a2b2b8c359e338f1a7818b';

/// See also [getListWheelFomula].
@ProviderFor(getListWheelFomula)
final getListWheelFomulaProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListWheelFomula,
  name: r'getListWheelFomulaProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListWheelFomulaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListWheelFomulaRef
    = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getListGearBoxHash() => r'd538308da70baa21fa466a0b234bbd27edce89fa';

/// See also [getListGearBox].
@ProviderFor(getListGearBox)
final getListGearBoxProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListGearBox,
  name: r'getListGearBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getListGearBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListGearBoxRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getListFuelsHash() => r'fc3019f61a8426570212a6252f3f9adeef1054d8';

/// See also [getListFuels].
@ProviderFor(getListFuels)
final getListFuelsProvider =
    AutoDisposeFutureProvider<List<KeyValueModel>>.internal(
  getListFuels,
  name: r'getListFuelsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getListFuelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetListFuelsRef = AutoDisposeFutureProviderRef<List<KeyValueModel>>;
String _$getVehicleBrandsHash() => r'25b586033dfe35bd63ca9edbe114505666bc5b5a';

/// See also [getVehicleBrands].
@ProviderFor(getVehicleBrands)
const getVehicleBrandsProvider = GetVehicleBrandsFamily();

/// See also [getVehicleBrands].
class GetVehicleBrandsFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getVehicleBrands].
  const GetVehicleBrandsFamily();

  /// See also [getVehicleBrands].
  GetVehicleBrandsProvider call(
    VehicleTypeEnum type,
  ) {
    return GetVehicleBrandsProvider(
      type,
    );
  }

  @override
  GetVehicleBrandsProvider getProviderOverride(
    covariant GetVehicleBrandsProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'getVehicleBrandsProvider';
}

/// See also [getVehicleBrands].
class GetVehicleBrandsProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getVehicleBrands].
  GetVehicleBrandsProvider(
    VehicleTypeEnum type,
  ) : this._internal(
          (ref) => getVehicleBrands(
            ref as GetVehicleBrandsRef,
            type,
          ),
          from: getVehicleBrandsProvider,
          name: r'getVehicleBrandsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getVehicleBrandsHash,
          dependencies: GetVehicleBrandsFamily._dependencies,
          allTransitiveDependencies:
              GetVehicleBrandsFamily._allTransitiveDependencies,
          type: type,
        );

  GetVehicleBrandsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final VehicleTypeEnum type;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetVehicleBrandsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetVehicleBrandsProvider._internal(
        (ref) => create(ref as GetVehicleBrandsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetVehicleBrandsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetVehicleBrandsProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetVehicleBrandsRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `type` of this provider.
  VehicleTypeEnum get type;
}

class _GetVehicleBrandsProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetVehicleBrandsRef {
  _GetVehicleBrandsProviderElement(super.provider);

  @override
  VehicleTypeEnum get type => (origin as GetVehicleBrandsProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
