import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/utils/utils.dart';
import 'key_value_model.dart';

typedef InputFieldWidgetBuilder<T> = Widget Function(
    BuildContext context, WidgetRef ref, VoidCallback tap, dynamic data);

typedef SuffixIconWidgetBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
);

class InputFieldModel<T> extends Equatable {
  TextEditingController? textEditingController;
  // String? key;
  String? label;
  String? hint;
  String? value;
  int? maxLines;
  int? minLines;
  String? Function(String?)? validator;
  TextInputAction? inputAction;
  TextInputType inputType;
  List<TextInputFormatter>? inputFormatter;
  InputFieldType inputFieldType;
  KeyValueModel? selectedValue;
  List<KeyValueModel>? lsDropDown;
  Function(KeyValueModel?)? onChange;
  Function(KeyValueModel?)? firstLoadedItemCallBack;

  bool Function(String)? checkAllowEnterText;
  void Function(dynamic)? onTextChanged;
  FocusNode? focusNode;
  int? nextIndex;
  bool? enable;
  bool? readOnly;
  InputFieldWidgetBuilder<T>? widgetBuilder;
  Function(BuildContext, TextEditingController)? onTap;
  AutovalidateMode? autoValidateMode;

  ///Suffix icon dùng cho trường hợp có nhiều icon bên phải của text field
  SuffixIconWidgetBuilder? suffixIcon;
  Widget? trailingIcon;
  Function()? onClickTrigger;
  Function(KeyValueModel?)? setSelectedValue;
  Function(Function(List<KeyValueModel>?))? checkShowBottomSheet;
  Function(Function(AutoDisposeFutureProvider<List<KeyValueModel>>?))?
      listDataProvider;
  Function(String)? updateText;
  StateProvider<KeyValueModel?>? selectedItemProvider;
  T? data;

  ///Kiểm tra để thêm format tiền tệ
  bool isCurrency = false;

  ///Temp value dành cho đoạn đường trong khung giá
  bool allowValidate = false;

  ///
  bool showTitle = true;

  bool? _isRequired = false;

  int? maxLength;

  InputFieldModel({
    this.label,
    this.hint,
    this.value,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.inputAction = TextInputAction.next,
    this.inputFormatter,
    this.selectedValue,
    this.lsDropDown,
    this.onChange,
    this.firstLoadedItemCallBack,
    this.inputType = TextInputType.text,
    this.inputFieldType = InputFieldType.normal,
    this.nextIndex,
    this.widgetBuilder,
    this.enable,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    this.trailingIcon,
    this.checkShowBottomSheet,
    this.listDataProvider,
    this.selectedItemProvider,
    this.onTextChanged,
    this.data,
    this.updateText,
    this.setSelectedValue,
    this.onClickTrigger,
    this.checkAllowEnterText,
    bool required = false,
    this.isCurrency = false,
    this.showTitle = true,
    this.textEditingController,
    this.maxLength,
    this.autoValidateMode,
  }) {
    this._isRequired = required;
    focusNode = FocusNode();
    var type = T.toString();
    if (type == 'int' || type == 'double') {
      var isDouble = type == 'double';
      inputType = TextInputType.numberWithOptions(decimal: isDouble);
      if (inputFormatter == null) {
        inputFormatter ??= [];
        if (isDouble) {
          inputFormatter?.add(ReplaceCommaFormatter());
          inputFormatter?.add(NumericTextFormatter());
        } else {
          inputFormatter?.add(IntTextFormatter());
        }
      }
    }

    hint ??=
        '${inputFieldType == InputFieldType.dropDown ? 'Chọn' : 'Nhập'} ${(label ?? '').toLowerCase()}';

    if (data.runtimeType.toString().contains('DateTime')) {
      value = (data as DateTime).toStringFormat();
    }

    value ??= getDataContent;

    updateText ??= (newText) {
      value = newText;
    };

    setSelectedValue ??= (p0) {
      selectedValue = p0;
    };

    if (required == true && validator == null) {
      validator = (value) {
        return validateValue(label ?? '', value);
      };
    }

    if (validator != null && _isRequired == null) {
      _isRequired = true;
    }

    if (inputFieldType == InputFieldType.customSelect ||
        inputFieldType == InputFieldType.dropDown) {
      readOnly = true;
    }
  }

  String? content() {
    var resultText = value ?? '';
    if (resultText.isEmpty && inputFieldType == InputFieldType.dropDown) {
      resultText = selectedValue?.title ?? selectedValue?.key ?? '';
    }
    if (resultText.trim().isNotEmpty) return resultText;
    return null;
  }

  void dispose() {
    focusNode?.dispose();
  }

  String? validateValue(String label, String? value) {
    if ((value ?? '').isEmpty) {
      return 'Vui lòng ${inputFieldType == InputFieldType.dropDown ? 'chọn' : 'nhập'} ${label.toLowerCase()}';
    }
    return null;
  }

  String get getDataContent {
    // 100.5
    // 100,5
    try {
      if (data == null) return '';
      var result = data.toString();
      if (data is num) {
        result = formatterCurrency.format(data);
      }
      return result;
    } catch (e) {
      return '';
    }
  }

  void setRequire(bool isRequired) {
    _isRequired = isRequired;
    if (isRequired && validator == null) {
      validator = (value) {
        return validateValue(label ?? '', value);
      };
    } else {
      validator = null;
    }
  }

  bool get isRequired => _isRequired == true;

  @override
  List<Object?> get props => [value, data];
}

enum InputFieldType { normal, dropDown, select, custom, customSelect, date }

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      try {
        final newText = newValue.text;
        final oldText = oldValue.text;
        final isDelete = newText.length < oldText.length;
        final lastText = newText[newText.length - 1];
        if (lastText == ',') {
          ///Trường hợp dấu , cuối thì ko có format
          if (oldText.contains(',') && !isDelete) {
            return oldValue;
          }
          return newValue;
        }

        final int selectionIndexFromTheRight =
            newValue.text.length - newValue.selection.end;
        // print('$selectionIndexFromTheRight');

        var value = newValue.text.replaceAll('.', '');
        //còn trường hợp số 0 cuối cùng
        var decimalValue = newText.split(',');
        var doubleValue = formatterDouble.parse(decimalValue.first);

        value = formatterCurrency.format(doubleValue);
        if (decimalValue.length > 1) {
          var lastValue = decimalValue.last.replaceAll('.', '');
          if (lastValue.length > 3) {
            lastValue = lastValue.substring(0, 3);
          }
          value += ',$lastValue';
        }
        // Tính toán độ dài thay đổi để cập nhật vị trí con trỏ
        int offset =
            newValue.selection.baseOffset + (value.length - newText.length);
        // Đảm bảo rằng offset không âm và không vượt quá độ dài mới của văn bản
        offset = offset.clamp(0, value.length);
        return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(
            offset: offset,
          ),
        );
      } catch (e) {
        return oldValue;
      }
    } else {
      return newValue;
    }
  }
}

class IntTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      try {
        final int selectionIndexFromTheRight =
            newValue.text.length - newValue.selection.end;
        var value = newValue.text.replaceAll('.', '');
        value = formatterCurrency.format(int.parse(value));
        // Tính toán độ dài thay đổi để cập nhật vị trí con trỏ
        int offset = newValue.selection.baseOffset +
            (value.length - newValue.text.length);
        // Đảm bảo rằng offset không âm và không vượt quá độ dài mới của văn bản
        offset = offset.clamp(0, value.length);
        return TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(
            offset: offset,
          ),
        );
      } catch (e) {
        return oldValue;
      }
    } else {
      return newValue;
    }
  }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Xác định vị trí của dấu "." được nhập bằng cách so sánh oldValue và newValue
    if (newValue.text.length > oldValue.text.length) {
      int insertedPosition = newValue.selection.start - 1;
      if (newValue.text[insertedPosition] == '.') {
        // Thay thế dấu "." bằng dấu ","
        String newText =
            '${newValue.text.substring(0, insertedPosition)},${newValue.text.substring(insertedPosition + 1)}';
        // Đảm bảo chỉ có một dấu "," được sử dụng làm dấu thập phân
        int firstCommaIndex = newText.indexOf(',');
        if (firstCommaIndex != -1) {
          newText = newText.substring(0, firstCommaIndex + 1) +
              newText.substring(firstCommaIndex + 1).replaceAll(',', '');
        }
        return TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: insertedPosition + 1),
        );
      }
    }
    return newValue;
  }
}
