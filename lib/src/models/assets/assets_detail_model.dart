// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/assets/ptdb_model.dart';
import 'package:sba/src/models/assets/ptdt_model.dart';

part 'assets_detail_model.g.dart';

//Chi tiết tài sản
@JsonSerializable()
class AssetsDetailModel<T> {
  String? assetCode;
  int? assetLevelThreeId;
  int? assetLevelTwoId;
  @_Converter()
  T? assetObject;
  @JsonKey(includeToJson: false)
  List<Attachment> assetImages;
  @JsonKey(includeToJson: false)
  List<Attachment> diagramImages;
  @JsonKey(includeToJson: false)
  List<Attachment> otherImages;

  T get asset => assetObject!;

  AssetsDetailModel({
    this.assetCode,
    this.assetLevelThreeId,
    this.assetLevelTwoId,
    required this.assetObject,
    this.assetImages = const [],
    this.diagramImages = const [],
    this.otherImages = const [],
  });

  factory AssetsDetailModel.fromJson(dynamic json) =>
      _$AssetsDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsDetailModelToJson(this);

  AssetsDetailModel<T> copyWith({
    String? assetCode,
    int? assetLevelThreeId,
    T? assetObject,
  }) {
    return AssetsDetailModel<T>(
      assetCode: assetCode ?? this.assetCode,
      assetLevelThreeId: assetLevelThreeId ?? this.assetLevelThreeId,
      assetObject: assetObject ?? this.assetObject,
    );
  }
}

class _Converter<T> implements JsonConverter<T?, Object?> {
  const _Converter();

  @override
  T? fromJson(Object? json) {
    if (json == null) return null;

    switch (T.toString()) {
      case 'RealEstateModel?':
        return RealEstateModel.fromJson(json as Map<String, dynamic>) as T;
      case 'CHCCModel?':
        return CHCCModel.fromJson(json as Map<String, dynamic>) as T;
      case 'PTDBModel?':
        return PTDBModel.fromJson(json as Map<String, dynamic>) as T;
      case 'MMTBModel?':
        return MMTBModel.fromJson(json as Map<String, dynamic>) as T;
      case 'PTDTModel?':
        return PTDTModel.fromJson(json as Map<String, dynamic>) as T;
      case 'DuAnModel?':
        return DuAnModel.fromJson(json as Map<String, dynamic>) as T;
      default:
        throw Exception('Kiểu dữ liệu không hỗ trợ');
    }
  }

  @override
  Object? toJson(T? object) => object;
}
