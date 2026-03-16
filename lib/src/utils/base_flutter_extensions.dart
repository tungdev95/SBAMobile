import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart' as intl;

const defaultFormat = 'dd/MM/yyyy';
const showInfoDateFormat = 'dd/MM/yyyy HH:mm:ss';
const showSurveyTimeFormat = 'dd/MM/yyyy HH:mm';
const showInfoDateFormatReport = 'HH mm d M yyyy';

NumberFormat formatterDouble = NumberFormat.decimalPatternDigits(
  locale: 'vi',
)..minimumFractionDigits = 0;

NumberFormat formatterCurrency = NumberFormat.decimalPatternDigits(
  locale: 'vi',
);

extension DateTimeEX on DateTime? {
  String toStringFormat([String format = defaultFormat]) {
    if (this == null) return '';
    try {
      return DateFormat(format).format(this!);
    } catch (e) {
      return '';
    }
  }
}

extension StringEX on String {
  DateTime dateFromString([String format = defaultFormat]) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return DateTime.now();
    }
  }

  String stringValue() {
    return split('.').last;
  }

  String formatNumberString() {
    try {
      final formatter = intl.NumberFormat.decimalPattern('vi')
        ..maximumFractionDigits = 3;
      final number = replaceAll('.', '');
      return formatter.format(double.tryParse(number));
    } catch (e) {
      return this;
    }
  }

  T toEnum<T>(List<T> list) => list.firstWhere((d) => d.toString() == this);

  MediaType? get mimeType {
    if ((this).toLowerCase().endsWith('heic')) {
      return MediaType.parse('image/heic');
    } else {
      final mimeType = lookupMimeType(this);
      if (mimeType == null) return null;
      return MediaType.parse(mimeType);
    }
  }
}

const double baseScreenWidth = 375.0;

extension BuildContextEX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double? get iconSize => IconTheme.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  ///Normal text font size 13
  TextStyle get textNormal =>
      textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400);
  TextStyle get textNormalMedium =>
      textNormal.copyWith(fontWeight: FontWeight.w500);
  TextStyle get textNormalLight =>
      textMedium.copyWith(fontWeight: FontWeight.w300);
  TextStyle get textNormalBold =>
      textNormal.copyWith(fontWeight: FontWeight.w700);

  ///Medium text font size 15
  TextStyle get textMedium =>
      textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400);
  TextStyle get textMediumMedium =>
      textMedium.copyWith(fontWeight: FontWeight.w500);
  TextStyle get textMediumBold =>
      textMedium.copyWith(fontWeight: FontWeight.w700);
  TextStyle get textMediumLight =>
      textMedium.copyWith(fontWeight: FontWeight.w300);

  ///Medium text font size 17
  TextStyle get textLargeBold =>
      textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w700);
  TextStyle get textLargeMedium =>
      textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w500);
  TextStyle get textLarge =>
      textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w400);

  TextStyle get textTitle =>
      textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle get textTitleMedium =>
      textTitle.copyWith(fontWeight: FontWeight.w500);
  TextStyle get textTitleBold =>
      textTitle.copyWith(fontWeight: FontWeight.w700);
  TextStyle get textTitleLight =>
      textTitle.copyWith(fontWeight: FontWeight.w300);

  //get size ration by screen
  double sizeForRatio(double size) {
    return (screenSize.width / baseScreenWidth) * size;
  }

  //get size scale for fontsize max 1.8 ration
  double sizeForScale(double size) {
    double ratio = screenSize.width / baseScreenWidth;
    if (ratio > 1.8) {
      ratio = 1.8;
    }
    return ratio * size;
  }
}

extension IntEx on int? {
  String to2dFormat({bool allowEmpty = false}) {
    if (this == null) return allowEmpty ? '00' : '';
    if (this! < 10) return '0$this';
    return '$this';
  }
}

extension IterableExtension<T> on Iterable<T> {
  List<T> insertBetween(T item) => expand((e) sync* {
        yield item;
        yield e;
      }).skip(1).toList(growable: false);
}

extension NumEx on num? {
  String toPriceFormat([bool withUnit = false]) {
    if (this == null) return '';
    if (this == 0) return '0';
    // final formatter = NumberFormat('#.###,00', 'vi');
    // formatter.minimumIntegerDigits = 1;
    String newText = formatterCurrency.format(this);
    return '$newText${withUnit == true ? ' đ' : ''}';
  }

  String? toCurrencyFormat([bool withUnit = false]) {
    if (this == 0 || this == null) return '0';
    var intValue = this!.toInt();
    String newText = intValue.toString().replaceAll(RegExp(r'\D'), '');
    newText = newText.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return newText;
  }

  String text() {
    if (this == null) return '';
    final result = formatterDouble.format(this);
    return (intl.NumberFormat.decimalPattern('vi')..maximumFractionDigits = 3)
        .format(this);
  }

  double? format3Number() {
    if (this == null) return null;
    String resultInString = toString();
    if (resultInString.contains('.')) {
      final numberDecimal = resultInString.split('.').lastOrNull ?? '';
      if (numberDecimal.length > 3) {
        return double.parse(this!.toStringAsFixed(3));
      }
    }
    return this as double;
  }
}

extension Typing<T> on List<T> {
  Type get genericType => T;
}

extension ExpandX on List<ExpandModel> {
  // String errorText({String? parentLevel}) {
  //   this.forEach((element) {
  //     if (element.child.isNotEmpty) {
  //       return errorText()
  //     }
  //   });
  // }
}

extension NullCheck<T> on T? {
  void let(Function(T) notNull) {
    if (this != null) notNull(this as T);
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension ResetStateEx on AutoDisposeRef {
  void registerKeepAlive() {
    final life = keepAlive();
    listen(
      appController,
      (previous, next) {
        if ((next.userLogin?.accessToken ?? '').isEmpty) {
          life.close();
        }
      },
    );
  }
}

/// Useful extension for [XFile]
extension XFileX on XFile {
  /// Converts the [PlatformFile] into [AttachmentFile]
  Future<AttachmentFile> get toAttachmentFile async {
    final bytes = await readAsBytes();
    return AttachmentFile(
      name: name,
      size: bytes.length,
      path: path,
      bytes: bytes,
    );
  }

  /// Converts the [XFile] to a [Attachment].
  Future<Attachment> toAttachment() async {
    final file = await toAttachmentFile;

    final extraDataMap = <String, Object>{};

    final mimeType = this.mimeType ?? file.mimeType?.mimeType;

    if (mimeType != null) {
      extraDataMap['mimeType'] = mimeType;
    }

    extraDataMap['fileSize'] = file.size!;

    final attachment = Attachment(
      file: file,
    );

    return attachment;
  }
}

extension Uint8ListX on Uint8List {
  AttachmentFile toAttachment({String? name}) {
    var mime = lookupMimeType('', headerBytes: this);
    var extension = extensionFromMime(mime ?? '');

    return AttachmentFile(
      name: '${name ?? '${DateTime.now().millisecondsSinceEpoch}'}.$extension',
      size: length,
      // path: path,
      bytes: this,
    );
  }
}

/// A method returns a human readable string representing a file _size
String fileSize(dynamic size, [int round = 2]) {
  if (size == null) return 'Size N/A';

  /**
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number
   * of digits after comma/point (default is 2)
   */
  const divider = 1024;
  int _size;
  try {
    _size = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError('Can not parse the size parameter: $e');
  }

  if (_size < divider) {
    return '$_size B';
  }

  if (_size < divider * divider && _size % divider == 0) {
    return '${(_size / divider).toStringAsFixed(0)} KB';
  }

  if (_size < divider * divider) {
    return '${(_size / divider).toStringAsFixed(round)} KB';
  }

  if (_size < divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
  }

  if (_size < divider * divider * divider) {
    return '${(_size / divider / divider).toStringAsFixed(round)} MB';
  }

  if (_size < divider * divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
  }

  if (_size < divider * divider * divider * divider) {
    return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
  }

  if (_size < divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    final num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} TB';
  }

  if (_size < divider * divider * divider * divider * divider) {
    final num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} TB';
  }

  if (_size < divider * divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    final num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} PB';
  } else {
    final num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} PB';
  }
}

extension RefEx on AutoDisposeFutureProviderRef {
  void shouldKeepAlive<T>(ApiResponse<T> data, int pageIndex) {
    KeepAliveLink? link;
    if (data.status == Status.complete && pageIndex == 1) {
      link = keepAlive();
      listen(appController, (previous, next) {
        if (previous?.userLogin != next.userLogin) {
          link?.close();
        }
      });
    }
  }
}
