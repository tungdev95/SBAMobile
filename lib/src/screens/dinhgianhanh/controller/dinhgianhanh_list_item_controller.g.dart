// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dinhgianhanh_list_item_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListAssetsHash() => r'f226c0e92f76dfe2dc60664b7f44b3a177f5dfed';

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

/// See also [_getListAssets].
@ProviderFor(_getListAssets)
const _getListAssetsProvider = _GetListAssetsFamily();

/// See also [_getListAssets].
class _GetListAssetsFamily
    extends Family<AsyncValue<ApiResponse<List<FastValuationModel>?>>> {
  /// See also [_getListAssets].
  const _GetListAssetsFamily();

  /// See also [_getListAssets].
  _GetListAssetsProvider call({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
  }) {
    return _GetListAssetsProvider(
      pageIndex: pageIndex,
      assetsType: assetsType,
    );
  }

  @override
  _GetListAssetsProvider getProviderOverride(
    covariant _GetListAssetsProvider provider,
  ) {
    return call(
      pageIndex: provider.pageIndex,
      assetsType: provider.assetsType,
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
  String? get name => r'_getListAssetsProvider';
}

/// See also [_getListAssets].
class _GetListAssetsProvider
    extends AutoDisposeFutureProvider<ApiResponse<List<FastValuationModel>?>> {
  /// See also [_getListAssets].
  _GetListAssetsProvider({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
  }) : this._internal(
          (ref) => _getListAssets(
            ref as _GetListAssetsRef,
            pageIndex: pageIndex,
            assetsType: assetsType,
          ),
          from: _getListAssetsProvider,
          name: r'_getListAssetsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListAssetsHash,
          dependencies: _GetListAssetsFamily._dependencies,
          allTransitiveDependencies:
              _GetListAssetsFamily._allTransitiveDependencies,
          pageIndex: pageIndex,
          assetsType: assetsType,
        );

  _GetListAssetsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageIndex,
    required this.assetsType,
  }) : super.internal();

  final int? pageIndex;
  final AssetsTypeEnum? assetsType;

  @override
  Override overrideWith(
    FutureOr<ApiResponse<List<FastValuationModel>?>> Function(
            _GetListAssetsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetListAssetsProvider._internal(
        (ref) => create(ref as _GetListAssetsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageIndex: pageIndex,
        assetsType: assetsType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ApiResponse<List<FastValuationModel>?>>
      createElement() {
    return _GetListAssetsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListAssetsProvider &&
        other.pageIndex == pageIndex &&
        other.assetsType == assetsType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageIndex.hashCode);
    hash = _SystemHash.combine(hash, assetsType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetListAssetsRef
    on AutoDisposeFutureProviderRef<ApiResponse<List<FastValuationModel>?>> {
  /// The parameter `pageIndex` of this provider.
  int? get pageIndex;

  /// The parameter `assetsType` of this provider.
  AssetsTypeEnum? get assetsType;
}

class _GetListAssetsProviderElement extends AutoDisposeFutureProviderElement<
    ApiResponse<List<FastValuationModel>?>> with _GetListAssetsRef {
  _GetListAssetsProviderElement(super.provider);

  @override
  int? get pageIndex => (origin as _GetListAssetsProvider).pageIndex;
  @override
  AssetsTypeEnum? get assetsType =>
      (origin as _GetListAssetsProvider).assetsType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
