// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chcc_detail_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$getListDistrictHash() => r'893d37c44fb47c0b40cf7d08136d6373a247fa67';

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

/// See also [getListDistrict].
@ProviderFor(getListDistrict)
const getListDistrictProvider = GetListDistrictFamily();

/// See also [getListDistrict].
class GetListDistrictFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListDistrict].
  const GetListDistrictFamily();

  /// See also [getListDistrict].
  GetListDistrictProvider call(
    CHCCInfo chccInfo,
  ) {
    return GetListDistrictProvider(
      chccInfo,
    );
  }

  @override
  GetListDistrictProvider getProviderOverride(
    covariant GetListDistrictProvider provider,
  ) {
    return call(
      provider.chccInfo,
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
    CHCCInfo chccInfo,
  ) : this._internal(
          (ref) => getListDistrict(
            ref as GetListDistrictRef,
            chccInfo,
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
          chccInfo: chccInfo,
        );

  GetListDistrictProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chccInfo,
  }) : super.internal();

  final CHCCInfo chccInfo;

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
        chccInfo: chccInfo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListDistrictProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListDistrictProvider && other.chccInfo == chccInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chccInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListDistrictRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `chccInfo` of this provider.
  CHCCInfo get chccInfo;
}

class _GetListDistrictProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListDistrictRef {
  _GetListDistrictProviderElement(super.provider);

  @override
  CHCCInfo get chccInfo => (origin as GetListDistrictProvider).chccInfo;
}

String _$getListAddressHash() => r'a1ace4fc2be97dfaf9f925ffae1cbbfb859f64f4';

/// See also [getListAddress].
@ProviderFor(getListAddress)
const getListAddressProvider = GetListAddressFamily();

/// See also [getListAddress].
class GetListAddressFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [getListAddress].
  const GetListAddressFamily();

  /// See also [getListAddress].
  GetListAddressProvider call(
    CHCCInfo chccInfo,
  ) {
    return GetListAddressProvider(
      chccInfo,
    );
  }

  @override
  GetListAddressProvider getProviderOverride(
    covariant GetListAddressProvider provider,
  ) {
    return call(
      provider.chccInfo,
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
    CHCCInfo chccInfo,
  ) : this._internal(
          (ref) => getListAddress(
            ref as GetListAddressRef,
            chccInfo,
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
          chccInfo: chccInfo,
        );

  GetListAddressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chccInfo,
  }) : super.internal();

  final CHCCInfo chccInfo;

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
        chccInfo: chccInfo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _GetListAddressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetListAddressProvider && other.chccInfo == chccInfo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chccInfo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetListAddressRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `chccInfo` of this provider.
  CHCCInfo get chccInfo;
}

class _GetListAddressProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with GetListAddressRef {
  _GetListAddressProviderElement(super.provider);

  @override
  CHCCInfo get chccInfo => (origin as GetListAddressProvider).chccInfo;
}

String _$selectedProvinceItemHash() =>
    r'08566bd154cd64a9a2b0d80bde39fa6f677dff0a';

/// See also [selectedProvinceItem].
@ProviderFor(selectedProvinceItem)
const selectedProvinceItemProvider = SelectedProvinceItemFamily();

/// See also [selectedProvinceItem].
class SelectedProvinceItemFamily extends Family<KeyValueModel?> {
  /// See also [selectedProvinceItem].
  const SelectedProvinceItemFamily();

  /// See also [selectedProvinceItem].
  SelectedProvinceItemProvider call(
    CHCCInfo params,
  ) {
    return SelectedProvinceItemProvider(
      params,
    );
  }

  @override
  SelectedProvinceItemProvider getProviderOverride(
    covariant SelectedProvinceItemProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'selectedProvinceItemProvider';
}

/// See also [selectedProvinceItem].
class SelectedProvinceItemProvider extends AutoDisposeProvider<KeyValueModel?> {
  /// See also [selectedProvinceItem].
  SelectedProvinceItemProvider(
    CHCCInfo params,
  ) : this._internal(
          (ref) => selectedProvinceItem(
            ref as SelectedProvinceItemRef,
            params,
          ),
          from: selectedProvinceItemProvider,
          name: r'selectedProvinceItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedProvinceItemHash,
          dependencies: SelectedProvinceItemFamily._dependencies,
          allTransitiveDependencies:
              SelectedProvinceItemFamily._allTransitiveDependencies,
          params: params,
        );

  SelectedProvinceItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final CHCCInfo params;

  @override
  Override overrideWith(
    KeyValueModel? Function(SelectedProvinceItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedProvinceItemProvider._internal(
        (ref) => create(ref as SelectedProvinceItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<KeyValueModel?> createElement() {
    return _SelectedProvinceItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedProvinceItemProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedProvinceItemRef on AutoDisposeProviderRef<KeyValueModel?> {
  /// The parameter `params` of this provider.
  CHCCInfo get params;
}

class _SelectedProvinceItemProviderElement
    extends AutoDisposeProviderElement<KeyValueModel?>
    with SelectedProvinceItemRef {
  _SelectedProvinceItemProviderElement(super.provider);

  @override
  CHCCInfo get params => (origin as SelectedProvinceItemProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
