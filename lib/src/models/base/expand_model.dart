// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/utils/uuid.dart';

import 'input_field_model.dart';

typedef CopyLegalToReal = void Function();
typedef AddNewExpandClicked = void Function(
    BuildContext context, WidgetRef ref, String id);
typedef RemoveExpandClicked = void Function(
    BuildContext context, WidgetRef ref, String id);
typedef TrailingExpandWidgetBuilder = Widget Function(
    BuildContext context, WidgetRef ref);

class ExpandModel extends Equatable {
  String id;
  String? key;
  String title;
  bool isExpand;

  ///Check có generate thêm index sau title hay không
  bool generateTitleIndex;

  ///Danh sách nằm phía trên item pháp lý và thực tế (nếu có)
  List<InputFieldModel> topLsInputField;

  ///Dùng cho trường hợp Expand multi level
  List<ExpandModel> child;
  List<InputFieldModel> lsInputField;
  CopyLegalToReal? copyLegalToFactual;

  ///Click thêm mới 1 item
  AddNewExpandClicked? addNewExpandClicked;

  ///Click xóa 1 item
  RemoveExpandClicked? removeExpandClicked;
  TrailingExpandWidgetBuilder? trailingExpandWidgetBuilder;

  bool allowAdd;
  bool allowDelete;

  ExpandModel({
    this.id = '',
    required this.title,
    required this.isExpand,
    required this.child,
    required this.lsInputField,
    this.generateTitleIndex = false,
    required this.topLsInputField,
    this.key,
    this.copyLegalToFactual,
    this.allowAdd = false,
    this.allowDelete = false,
    this.addNewExpandClicked,
    this.removeExpandClicked,
    this.trailingExpandWidgetBuilder,
  }) {
    id = Uuid().generateV4();
  }

  ExpandModel copyWith({
    String? id,
    String? title,
    bool? isExpand,
    List<ExpandModel>? child,
    List<InputFieldModel>? lsInputField,
    List<InputFieldModel>? topLsInputField,
    String? key,
    bool? allowAdd,
    bool? allowDelete,
    CopyLegalToReal? copyLegalToFactual,
    AddNewExpandClicked? addNewExpandClicked,
    RemoveExpandClicked? removeExpandClicked,
    TrailingExpandWidgetBuilder? trailingExpandWidgetBuilder,
  }) {
    return ExpandModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isExpand: isExpand ?? this.isExpand,
      child: child ?? this.child,
      lsInputField: lsInputField ?? this.lsInputField,
      key: key ?? this.key,
      allowAdd: allowAdd ?? this.allowAdd,
      allowDelete: allowDelete ?? this.allowDelete,
      copyLegalToFactual: copyLegalToFactual ?? this.copyLegalToFactual,
      addNewExpandClicked: addNewExpandClicked ?? this.addNewExpandClicked,
      removeExpandClicked: removeExpandClicked ?? this.removeExpandClicked,
      trailingExpandWidgetBuilder:
          trailingExpandWidgetBuilder ?? this.trailingExpandWidgetBuilder,
      topLsInputField: topLsInputField ?? this.topLsInputField,
    );
  }

  @override
  List<Object?> get props => [
        isExpand,
        title,
        child,
        lsInputField,
        key,
        topLsInputField,
        allowAdd,
        allowDelete,
        copyLegalToFactual,
        addNewExpandClicked,
        removeExpandClicked,
        trailingExpandWidgetBuilder,
      ];

  String getError() {
    for (var element in child) {
      final content = element.getError();
      if (content.isNotEmpty) return content;
    }
    for (var element in [...lsInputField, ...topLsInputField]) {
      final content = element.validator?.call(element.content()) ?? '';
      if (content.isNotEmpty) return '${element.label}: $content';
    }
    return '';
  }
}
