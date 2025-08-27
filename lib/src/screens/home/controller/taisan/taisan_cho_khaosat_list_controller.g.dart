// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taisan_cho_khaosat_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getListAssetsHash() => r'a970b418c3c16261f171ad398ff5ce397b555291';

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
    extends Family<AsyncValue<ApiResponse<List<AssetsModel>?>>> {
  /// See also [_getListAssets].
  const _GetListAssetsFamily();

  /// See also [_getListAssets].
  _GetListAssetsProvider call({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
    FileStatus? fileStatus,
  }) {
    return _GetListAssetsProvider(
      pageIndex: pageIndex,
      assetsType: assetsType,
      fileStatus: fileStatus,
    );
  }

  @override
  _GetListAssetsProvider getProviderOverride(
    covariant _GetListAssetsProvider provider,
  ) {
    return call(
      pageIndex: provider.pageIndex,
      assetsType: provider.assetsType,
      fileStatus: provider.fileStatus,
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
    extends AutoDisposeFutureProvider<ApiResponse<List<AssetsModel>?>> {
  /// See also [_getListAssets].
  _GetListAssetsProvider({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
    FileStatus? fileStatus,
  }) : this._internal(
          (ref) => _getListAssets(
            ref as _GetListAssetsRef,
            pageIndex: pageIndex,
            assetsType: assetsType,
            fileStatus: fileStatus,
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
          fileStatus: fileStatus,
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
    required this.fileStatus,
  }) : super.internal();

  final int? pageIndex;
  final AssetsTypeEnum? assetsType;
  final FileStatus? fileStatus;

  @override
  Override overrideWith(
    FutureOr<ApiResponse<List<AssetsModel>?>> Function(
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
        fileStatus: fileStatus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ApiResponse<List<AssetsModel>?>>
      createElement() {
    return _GetListAssetsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListAssetsProvider &&
        other.pageIndex == pageIndex &&
        other.assetsType == assetsType &&
        other.fileStatus == fileStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageIndex.hashCode);
    hash = _SystemHash.combine(hash, assetsType.hashCode);
    hash = _SystemHash.combine(hash, fileStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetListAssetsRef
    on AutoDisposeFutureProviderRef<ApiResponse<List<AssetsModel>?>> {
  /// The parameter `pageIndex` of this provider.
  int? get pageIndex;

  /// The parameter `assetsType` of this provider.
  AssetsTypeEnum? get assetsType;

  /// The parameter `fileStatus` of this provider.
  FileStatus? get fileStatus;
}

class _GetListAssetsProviderElement
    extends AutoDisposeFutureProviderElement<ApiResponse<List<AssetsModel>?>>
    with _GetListAssetsRef {
  _GetListAssetsProviderElement(super.provider);

  @override
  int? get pageIndex => (origin as _GetListAssetsProvider).pageIndex;
  @override
  AssetsTypeEnum? get assetsType =>
      (origin as _GetListAssetsProvider).assetsType;
  @override
  FileStatus? get fileStatus => (origin as _GetListAssetsProvider).fileStatus;
}

String _$getListAssetsSendHash() => r'e166c23e61308d74fc4c55e904c8c8a2652ceece';

/// See also [_getListAssetsSend].
@ProviderFor(_getListAssetsSend)
const _getListAssetsSendProvider = _GetListAssetsSendFamily();

/// See also [_getListAssetsSend].
class _GetListAssetsSendFamily
    extends Family<AsyncValue<ApiResponse<List<AssetsModel>?>>> {
  /// See also [_getListAssetsSend].
  const _GetListAssetsSendFamily();

  /// See also [_getListAssetsSend].
  _GetListAssetsSendProvider call({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
    FileStatus? fileStatus,
  }) {
    return _GetListAssetsSendProvider(
      pageIndex: pageIndex,
      assetsType: assetsType,
      fileStatus: fileStatus,
    );
  }

  @override
  _GetListAssetsSendProvider getProviderOverride(
    covariant _GetListAssetsSendProvider provider,
  ) {
    return call(
      pageIndex: provider.pageIndex,
      assetsType: provider.assetsType,
      fileStatus: provider.fileStatus,
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
  String? get name => r'_getListAssetsSendProvider';
}

/// See also [_getListAssetsSend].
class _GetListAssetsSendProvider
    extends AutoDisposeFutureProvider<ApiResponse<List<AssetsModel>?>> {
  /// See also [_getListAssetsSend].
  _GetListAssetsSendProvider({
    int? pageIndex,
    required AssetsTypeEnum? assetsType,
    FileStatus? fileStatus,
  }) : this._internal(
          (ref) => _getListAssetsSend(
            ref as _GetListAssetsSendRef,
            pageIndex: pageIndex,
            assetsType: assetsType,
            fileStatus: fileStatus,
          ),
          from: _getListAssetsSendProvider,
          name: r'_getListAssetsSendProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getListAssetsSendHash,
          dependencies: _GetListAssetsSendFamily._dependencies,
          allTransitiveDependencies:
              _GetListAssetsSendFamily._allTransitiveDependencies,
          pageIndex: pageIndex,
          assetsType: assetsType,
          fileStatus: fileStatus,
        );

  _GetListAssetsSendProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageIndex,
    required this.assetsType,
    required this.fileStatus,
  }) : super.internal();

  final int? pageIndex;
  final AssetsTypeEnum? assetsType;
  final FileStatus? fileStatus;

  @override
  Override overrideWith(
    FutureOr<ApiResponse<List<AssetsModel>?>> Function(
            _GetListAssetsSendRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetListAssetsSendProvider._internal(
        (ref) => create(ref as _GetListAssetsSendRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageIndex: pageIndex,
        assetsType: assetsType,
        fileStatus: fileStatus,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ApiResponse<List<AssetsModel>?>>
      createElement() {
    return _GetListAssetsSendProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetListAssetsSendProvider &&
        other.pageIndex == pageIndex &&
        other.assetsType == assetsType &&
        other.fileStatus == fileStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageIndex.hashCode);
    hash = _SystemHash.combine(hash, assetsType.hashCode);
    hash = _SystemHash.combine(hash, fileStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetListAssetsSendRef
    on AutoDisposeFutureProviderRef<ApiResponse<List<AssetsModel>?>> {
  /// The parameter `pageIndex` of this provider.
  int? get pageIndex;

  /// The parameter `assetsType` of this provider.
  AssetsTypeEnum? get assetsType;

  /// The parameter `fileStatus` of this provider.
  FileStatus? get fileStatus;
}

class _GetListAssetsSendProviderElement
    extends AutoDisposeFutureProviderElement<ApiResponse<List<AssetsModel>?>>
    with _GetListAssetsSendRef {
  _GetListAssetsSendProviderElement(super.provider);

  @override
  int? get pageIndex => (origin as _GetListAssetsSendProvider).pageIndex;
  @override
  AssetsTypeEnum? get assetsType =>
      (origin as _GetListAssetsSendProvider).assetsType;
  @override
  FileStatus? get fileStatus =>
      (origin as _GetListAssetsSendProvider).fileStatus;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
