// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_asset_detail_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$danhSachQuanHuyenHash() => r'03fd35c8e71fd603bfafeeee6d2cf35b9015d3c2';

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

/// See also [danhSachQuanHuyen].
@ProviderFor(danhSachQuanHuyen)
const danhSachQuanHuyenProvider = DanhSachQuanHuyenFamily();

/// See also [danhSachQuanHuyen].
class DanhSachQuanHuyenFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [danhSachQuanHuyen].
  const DanhSachQuanHuyenFamily();

  /// See also [danhSachQuanHuyen].
  DanhSachQuanHuyenProvider call(
    AssetCommons asset,
  ) {
    return DanhSachQuanHuyenProvider(
      asset,
    );
  }

  @override
  DanhSachQuanHuyenProvider getProviderOverride(
    covariant DanhSachQuanHuyenProvider provider,
  ) {
    return call(
      provider.asset,
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
  String? get name => r'danhSachQuanHuyenProvider';
}

/// See also [danhSachQuanHuyen].
class DanhSachQuanHuyenProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [danhSachQuanHuyen].
  DanhSachQuanHuyenProvider(
    AssetCommons asset,
  ) : this._internal(
          (ref) => danhSachQuanHuyen(
            ref as DanhSachQuanHuyenRef,
            asset,
          ),
          from: danhSachQuanHuyenProvider,
          name: r'danhSachQuanHuyenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$danhSachQuanHuyenHash,
          dependencies: DanhSachQuanHuyenFamily._dependencies,
          allTransitiveDependencies:
              DanhSachQuanHuyenFamily._allTransitiveDependencies,
          asset: asset,
        );

  DanhSachQuanHuyenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.asset,
  }) : super.internal();

  final AssetCommons asset;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(DanhSachQuanHuyenRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DanhSachQuanHuyenProvider._internal(
        (ref) => create(ref as DanhSachQuanHuyenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        asset: asset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _DanhSachQuanHuyenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DanhSachQuanHuyenProvider && other.asset == asset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asset.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DanhSachQuanHuyenRef
    on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `asset` of this provider.
  AssetCommons get asset;
}

class _DanhSachQuanHuyenProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with DanhSachQuanHuyenRef {
  _DanhSachQuanHuyenProviderElement(super.provider);

  @override
  AssetCommons get asset => (origin as DanhSachQuanHuyenProvider).asset;
}

String _$danhSachDuongPhoHash() => r'52f81cef5f78d5ebc4df33705733880e00f55222';

/// See also [danhSachDuongPho].
@ProviderFor(danhSachDuongPho)
const danhSachDuongPhoProvider = DanhSachDuongPhoFamily();

/// See also [danhSachDuongPho].
class DanhSachDuongPhoFamily extends Family<AsyncValue<List<KeyValueModel>>> {
  /// See also [danhSachDuongPho].
  const DanhSachDuongPhoFamily();

  /// See also [danhSachDuongPho].
  DanhSachDuongPhoProvider call(
    AssetCommons asset,
  ) {
    return DanhSachDuongPhoProvider(
      asset,
    );
  }

  @override
  DanhSachDuongPhoProvider getProviderOverride(
    covariant DanhSachDuongPhoProvider provider,
  ) {
    return call(
      provider.asset,
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
  String? get name => r'danhSachDuongPhoProvider';
}

/// See also [danhSachDuongPho].
class DanhSachDuongPhoProvider
    extends AutoDisposeFutureProvider<List<KeyValueModel>> {
  /// See also [danhSachDuongPho].
  DanhSachDuongPhoProvider(
    AssetCommons asset,
  ) : this._internal(
          (ref) => danhSachDuongPho(
            ref as DanhSachDuongPhoRef,
            asset,
          ),
          from: danhSachDuongPhoProvider,
          name: r'danhSachDuongPhoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$danhSachDuongPhoHash,
          dependencies: DanhSachDuongPhoFamily._dependencies,
          allTransitiveDependencies:
              DanhSachDuongPhoFamily._allTransitiveDependencies,
          asset: asset,
        );

  DanhSachDuongPhoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.asset,
  }) : super.internal();

  final AssetCommons asset;

  @override
  Override overrideWith(
    FutureOr<List<KeyValueModel>> Function(DanhSachDuongPhoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DanhSachDuongPhoProvider._internal(
        (ref) => create(ref as DanhSachDuongPhoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        asset: asset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<KeyValueModel>> createElement() {
    return _DanhSachDuongPhoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DanhSachDuongPhoProvider && other.asset == asset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asset.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DanhSachDuongPhoRef on AutoDisposeFutureProviderRef<List<KeyValueModel>> {
  /// The parameter `asset` of this provider.
  AssetCommons get asset;
}

class _DanhSachDuongPhoProviderElement
    extends AutoDisposeFutureProviderElement<List<KeyValueModel>>
    with DanhSachDuongPhoRef {
  _DanhSachDuongPhoProviderElement(super.provider);

  @override
  AssetCommons get asset => (origin as DanhSachDuongPhoProvider).asset;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
