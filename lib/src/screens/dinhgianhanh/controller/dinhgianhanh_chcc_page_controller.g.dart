// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dinhgianhanh_chcc_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$getListAddressHash() => r'434f6cf88da835fe9d241376aaa96291e5060cbe';

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
    CHCCFastValModel landInfo,
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
    CHCCFastValModel landInfo,
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

  final CHCCFastValModel landInfo;

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
  CHCCFastValModel get landInfo;
}

class _GetListAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListAddressRef {
  _GetListAddressProviderElement(super.provider);

  @override
  CHCCFastValModel get landInfo => (origin as GetListAddressProvider).landInfo;
}

String _$getListDistrictHash() => r'cfb559e290bc7d5f5ac400c3ad14b8e868e5eaf1';

/// See also [getListDistrict].
@ProviderFor(getListDistrict)
const getListDistrictProvider = GetListDistrictFamily();

/// See also [getListDistrict].
class GetListDistrictFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDistrict].
  const GetListDistrictFamily();

  /// See also [getListDistrict].
  GetListDistrictProvider call(
    CHCCFastValModel landInfo,
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
    CHCCFastValModel landInfo,
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

  final CHCCFastValModel landInfo;

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
  CHCCFastValModel get landInfo;
}

class _GetListDistrictProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDistrictRef {
  _GetListDistrictProviderElement(super.provider);

  @override
  CHCCFastValModel get landInfo => (origin as GetListDistrictProvider).landInfo;
}

String _$getListDuAnHash() => r'2b15521ced02cf97ccc80f7747b2ee597bb0d605';

/// See also [getListDuAn].
@ProviderFor(getListDuAn)
const getListDuAnProvider = GetListDuAnFamily();

/// See also [getListDuAn].
class GetListDuAnFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDuAn].
  const GetListDuAnFamily();

  /// See also [getListDuAn].
  GetListDuAnProvider call(
    String? textSearch,
  ) {
    return GetListDuAnProvider(
      textSearch,
    );
  }

  @override
  GetListDuAnProvider getProviderOverride(
    covariant GetListDuAnProvider provider,
  ) {
    return call(
      provider.textSearch,
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
  String? get name => r'getListDuAnProvider';
}

/// See also [getListDuAn].
class GetListDuAnProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListDuAn].
  GetListDuAnProvider(
    String? textSearch,
  ) : this._internal(
          (ref) => getListDuAn(
            ref as GetListDuAnRef,
            textSearch,
          ),
          from: getListDuAnProvider,
          name: r'getListDuAnProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListDuAnHash,
          dependencies: GetListDuAnFamily._dependencies,
          allTransitiveDependencies:
              GetListDuAnFamily._allTransitiveDependencies,
          textSearch: textSearch,
        );

  GetListDuAnProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.textSearch,
  }) : super.internal();

  final String? textSearch;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListDuAnRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListDuAnProvider._internal(
        (ref) => create(ref as GetListDuAnRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        textSearch: textSearch,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListDuAnProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListDuAnProvider && other.textSearch == textSearch;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, textSearch.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListDuAnRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `textSearch` of this provider.
  String? get textSearch;
}

class _GetListDuAnProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDuAnRef {
  _GetListDuAnProviderElement(super.provider);

  @override
  String? get textSearch => (origin as GetListDuAnProvider).textSearch;
}

String _$getListToaNhaHash() => r'7a595a81d4a54020a338d5b175ce9b39b600b7d7';

/// See also [getListToaNha].
@ProviderFor(getListToaNha)
const getListToaNhaProvider = GetListToaNhaFamily();

/// See also [getListToaNha].
class GetListToaNhaFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListToaNha].
  const GetListToaNhaFamily();

  /// See also [getListToaNha].
  GetListToaNhaProvider call(
    CHCCFastValModel landInfo,
    String? textSearch,
  ) {
    return GetListToaNhaProvider(
      landInfo,
      textSearch,
    );
  }

  @override
  GetListToaNhaProvider getProviderOverride(
    covariant GetListToaNhaProvider provider,
  ) {
    return call(
      provider.landInfo,
      provider.textSearch,
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
  String? get name => r'getListToaNhaProvider';
}

/// See also [getListToaNha].
class GetListToaNhaProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListToaNha].
  GetListToaNhaProvider(
    CHCCFastValModel landInfo,
    String? textSearch,
  ) : this._internal(
          (ref) => getListToaNha(
            ref as GetListToaNhaRef,
            landInfo,
            textSearch,
          ),
          from: getListToaNhaProvider,
          name: r'getListToaNhaProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListToaNhaHash,
          dependencies: GetListToaNhaFamily._dependencies,
          allTransitiveDependencies:
              GetListToaNhaFamily._allTransitiveDependencies,
          landInfo: landInfo,
          textSearch: textSearch,
        );

  GetListToaNhaProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.landInfo,
    required this.textSearch,
  }) : super.internal();

  final CHCCFastValModel landInfo;
  final String? textSearch;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListToaNhaRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListToaNhaProvider._internal(
        (ref) => create(ref as GetListToaNhaRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        landInfo: landInfo,
        textSearch: textSearch,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListToaNhaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListToaNhaProvider &&
        other.landInfo == landInfo &&
        other.textSearch == textSearch;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, landInfo.hashCode);
    hash = _SystemHash.combine(hash, textSearch.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListToaNhaRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `landInfo` of this provider.
  CHCCFastValModel get landInfo;

  /// The parameter `textSearch` of this provider.
  String? get textSearch;
}

class _GetListToaNhaProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListToaNhaRef {
  _GetListToaNhaProviderElement(super.provider);

  @override
  CHCCFastValModel get landInfo => (origin as GetListToaNhaProvider).landInfo;
  @override
  String? get textSearch => (origin as GetListToaNhaProvider).textSearch;
}

String _$getListBlockHash() => r'f2eee864f3be52ec05ada7387f12762c3c4cc8c5';

/// See also [getListBlock].
@ProviderFor(getListBlock)
const getListBlockProvider = GetListBlockFamily();

/// See also [getListBlock].
class GetListBlockFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListBlock].
  const GetListBlockFamily();

  /// See also [getListBlock].
  GetListBlockProvider call(
    CHCCFastValModel landInfo,
    String? textSearch,
  ) {
    return GetListBlockProvider(
      landInfo,
      textSearch,
    );
  }

  @override
  GetListBlockProvider getProviderOverride(
    covariant GetListBlockProvider provider,
  ) {
    return call(
      provider.landInfo,
      provider.textSearch,
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
  String? get name => r'getListBlockProvider';
}

/// See also [getListBlock].
class GetListBlockProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [getListBlock].
  GetListBlockProvider(
    CHCCFastValModel landInfo,
    String? textSearch,
  ) : this._internal(
          (ref) => getListBlock(
            ref as GetListBlockRef,
            landInfo,
            textSearch,
          ),
          from: getListBlockProvider,
          name: r'getListBlockProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListBlockHash,
          dependencies: GetListBlockFamily._dependencies,
          allTransitiveDependencies:
              GetListBlockFamily._allTransitiveDependencies,
          landInfo: landInfo,
          textSearch: textSearch,
        );

  GetListBlockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.landInfo,
    required this.textSearch,
  }) : super.internal();

  final CHCCFastValModel landInfo;
  final String? textSearch;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(GetListBlockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetListBlockProvider._internal(
        (ref) => create(ref as GetListBlockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        landInfo: landInfo,
        textSearch: textSearch,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListBlockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListBlockProvider &&
        other.landInfo == landInfo &&
        other.textSearch == textSearch;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, landInfo.hashCode);
    hash = _SystemHash.combine(hash, textSearch.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListBlockRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `landInfo` of this provider.
  CHCCFastValModel get landInfo;

  /// The parameter `textSearch` of this provider.
  String? get textSearch;
}

class _GetListBlockProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListBlockRef {
  _GetListBlockProviderElement(super.provider);

  @override
  CHCCFastValModel get landInfo => (origin as GetListBlockProvider).landInfo;
  @override
  String? get textSearch => (origin as GetListBlockProvider).textSearch;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
