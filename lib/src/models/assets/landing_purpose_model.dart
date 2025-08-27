// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:sba/src/utils/uuid.dart';
part 'landing_purpose_model.g.dart';

//Mục đích sử dụng đất
@JsonSerializable()
class LandingPurposeModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;
  //	Mục đích sử dụng ID
  int? usingPurposeId;
  //	Nguồn gốc sử dụng
  String? usingOrigin;
  //	Thời hạn sử dụng
  String? usingPeriod;
  //	Diện tích khuôn viên pháp lý
  double? legalAreaWidth;
  //	Diện tích phù hợp quy hoạch pháp lý
  @JsonKey(defaultValue: 0)
  double? legalAreaInPlan;
  double? legalAreaNotConsiderValue;
  //	Diện tích không phù hợp quy hoạch pháp lý
  double? legalAreaUnPlan;
  //	Diện tích sử dụng riêng pháp lý
  double? legalPrivateArea;
  //	Diện tích sử dụng chung pháp lý
  double? legalCommonArea;
  //	Diện tích khuôn viên thực tế
  double? realAreaWidth;
  //	Diện tích phù hợp quy hoạch thực tế
  @JsonKey(defaultValue: 0)
  double? realAreaInPlan;
  //	Diện tích không phù hợp quy hoạch thực tế
  double? realAreaUnPlan;
  //	Diện tích sử dụng riêng thực tế
  double? realPrivateArea;
  //	Diện tích sử dụng chung thực tế
  double? realCommonArea;

  double? realAreaNotConsiderValue;

  bool? isConsolidationPurposeParent;

  int? orderBy;

  LandingPurposeModel({
    this.usingPurposeId,
    this.usingOrigin,
    this.usingPeriod,
    this.legalAreaWidth,
    this.legalAreaInPlan,
    this.legalAreaUnPlan,
    this.legalPrivateArea,
    this.legalCommonArea,
    this.realAreaWidth,
    this.realAreaInPlan,
    this.realAreaUnPlan,
    this.realPrivateArea,
    this.realCommonArea,
    this.id,
    this.isConsolidationPurposeParent,
    this.orderBy,
    this.legalAreaNotConsiderValue,
    this.realAreaNotConsiderValue,
  }) {
    id ??= Uuid().generateV4();
  }

  factory LandingPurposeModel.fromJson(dynamic json) =>
      _$LandingPurposeModelFromJson(json);
  Map<String, dynamic> toJson() => _$LandingPurposeModelToJson(this);

  bool isValid() {
    // return usingPurposeId != null &&
    //     usingOrigin != null &&
    //     usingPeriod != null &&
    //     realAreaWidth != null &&
    //     realAreaInPlan != null &&
    //     realAreaUnPlan != null &&
    //     realPrivateArea != null &&
    //     realCommonArea != null;
    return usingPurposeId != null && realAreaWidth != null;
  }
}
