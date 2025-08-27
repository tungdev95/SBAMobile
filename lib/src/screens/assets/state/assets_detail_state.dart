// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';

class AssetsDetailState<T extends BaseDetailModel> {
  ///Item gốc đi từ danh sách tài sản
  AssetDetailProviderElement element;

  AssetsModel? surveyInfo;

  ///Thông tin chi tiết tài sản
  List<AssetsDetailModel<T>>? assets;

  ///Danh sách expand mặc định, nằm phía trên tab tài sản
  List<ExpandModel> defaultInfoList;

  ///Thông tin nhập liệu tài sản theo từng tab
  Map<String, List<ExpandModel>> assetInfo;

  List<Attachment> assetImages = [];
  // List<Attachment> diagramImages = [];
  // List<Attachment> otherImages = [];
  // List<Attachment> locationImages = [];
  // List<Attachment> zoningImages = [];
  // List<Attachment> anhDinhVi = [];

  AssetsDetailState({
    required this.element,
    this.assets,
    this.surveyInfo,
    this.defaultInfoList = const [],
    this.assetInfo = const {},
    required this.assetImages,
    // required this.diagramImages,
    // required this.otherImages,
    // required this.locationImages,
    // required this.zoningImages,
    // required this.anhDinhVi,
  });

  factory AssetsDetailState.element(AssetDetailProviderElement element) =>
      AssetsDetailState(
        element: element,
        assetImages: [],
        // diagramImages: [],
        // otherImages: [],
        // locationImages: [],
        // zoningImages: [],
        // anhDinhVi: [],
      );

  bool get haveLocationImage {
    return assetImages.any((element) =>
        element.type == ImageType.dinhVi || element.type == ImageType.location);
  }

  bool get haveZoningImage {
    return assetImages.any((element) => element.type == ImageType.zoning);
  }

  List<Attachment> get assetInfoImage =>
      assetImages.where((element) => element.type == ImageType.info).toList();

  List<Attachment> get diagramImages => assetImages
      .where((element) => element.type == ImageType.diagram)
      .toList();

  List<Attachment> get otherImages => assetImages
      .where((element) => element.type == ImageType.appendix)
      .toList();

  List<Attachment> get locationImages => assetImages
      .where((element) => element.type == ImageType.location)
      .toList();

  List<Attachment> get zoningImages =>
      assetImages.where((element) => element.type == ImageType.zoning).toList();

  List<Attachment> get anhDinhVi =>
      assetImages.where((element) => element.type == ImageType.dinhVi).toList();

  AssetsDetailState<T> copyWith({
    AssetsModel? surveyInfo,
    AssetDetailProviderElement? element,
    List<AssetsDetailModel<T>>? assets,
    List<ExpandModel>? defaultInfoList,
    Map<String, List<ExpandModel>>? assetInfo,
    List<Attachment>? assetImages,
  }) {
    return AssetsDetailState<T>(
      surveyInfo: surveyInfo ?? this.surveyInfo,
      element: element ?? this.element,
      assets: assets ?? this.assets,
      defaultInfoList: defaultInfoList ?? this.defaultInfoList,
      assetInfo: assetInfo ?? this.assetInfo,
      assetImages: assetImages ?? this.assetImages,
    );
  }

  AssetsDetailState<T> addNewImage({
    List<Attachment>? assetImages,
  }) {
    this.assetImages.addAll(assetImages ?? []);
    return AssetsDetailState<T>(
      surveyInfo: this.surveyInfo,
      element: this.element,
      assets: this.assets,
      defaultInfoList: this.defaultInfoList,
      assetInfo: this.assetInfo,
      assetImages: this.assetImages,
    );
  }
}

class AssetDetailProviderElement extends Equatable {
  AssetsModel? assetsModel;

  AssetDetailProviderElement({
    this.assetsModel,
  });

  @override
  List<Object?> get props => [assetsModel?.appraisalFileId];
}
