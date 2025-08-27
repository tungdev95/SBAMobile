// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/base/base.dart';

class DinhGiaNhanhState extends Equatable {
  List<AssetMenuModel<SvgGenImage>> lsMenuModel;
  AssetsTypeEnum? currentType;
  DinhGiaNhanhState({
    required this.lsMenuModel,
    this.currentType,
  });

  DinhGiaNhanhState copyWith({
    List<AssetMenuModel<SvgGenImage>>? lsMenuModel,
    AssetsTypeEnum? currentType,
  }) {
    return DinhGiaNhanhState(
      lsMenuModel: lsMenuModel ?? this.lsMenuModel,
      currentType: currentType ?? this.currentType,
    );
  }

  @override
  List<Object?> get props => [lsMenuModel.length, currentType];
}
