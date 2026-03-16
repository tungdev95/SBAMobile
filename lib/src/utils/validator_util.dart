import 'package:sba/src/utils/utils.dart';

mixin Validator {
  static String? validatePercent(String? text, {bool required = false}) {
    try {
      num? newValue = formatterDouble.parse(text ?? '');
      if (newValue <= 100) return null;
      if (newValue > 100) {
        return 'Vui lòng nhập giá trị nhỏ hơn 100';
      }
      return null;
    } catch (e) {
      if (required) return 'Vui lòng nhập giá trị';
      return null;
    }
  }

  static String? validateNegative(String? text) {
    double? newValue = double.tryParse(text ?? '') ?? 0.0;
    if (newValue < 0) return 'Không được phép nhỏ hơn 0';
    return null;
  }

  static String? validateYear(String? text, {bool required = true}) {
    final value = text ?? '';
    if (value.isEmpty && !required) return null;
    int newValue = int.tryParse(value) ?? 0;
    if (value.toString().length < 4) return 'Giá trị không hợp lệ';
    return null;
  }
}
