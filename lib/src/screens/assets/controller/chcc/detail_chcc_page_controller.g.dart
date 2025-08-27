// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_chcc_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$getListProvinceHash() => r'81736156b1ca259f9f0807e5a10bbbcf23932dfd';

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

String _$getListAddressHash() => r'364fca83f6d76e36485cc17ee2d814a907578acd';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
