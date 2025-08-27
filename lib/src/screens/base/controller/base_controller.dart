import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sba/sba_app.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:riverpod/riverpod.dart';

class BaseController<T> extends StateNotifier<T> {
  final tTinTranhChap = [
    KeyValueModel(key: '0', title: 'Không'),
    KeyValueModel(key: '1', title: 'Có'),
    KeyValueModel(key: '2', title: 'Không xác định'),
  ];

  final tinhThanhKhoan = [
    KeyValueModel(key: '1', title: 'Tốt'),
    KeyValueModel(key: '2', title: 'Trung Bình'),
    KeyValueModel(key: '3', title: 'Kém'),
  ];

  final lsQuyHoach = [
    KeyValueModel(key: 'có', title: 'Có'),
    KeyValueModel(key: 'không', title: 'Không'),
  ];

  final lsQuyHoachBDS = [
    KeyValueModel(key: 'Có', title: 'Có'),
    KeyValueModel(key: 'Không', title: 'Không'),
  ];

  BaseController(T state, this.ref) : super(state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialLoad();
    });
  }

  final Ref ref;
  bool isLoading = false;
  bool isShowLoading = false;
  int pageIndex = 1;
  bool isAvailableLoadMore = true;
  bool isShowingDialog = false;
  bool isShowLoadingDialog = false;
  BuildContext get context => SBAApp.navigatorKey.currentState!.context;

  String? get tag => runtimeType.toString();

  Future<void> initialLoad() async {
    hideKeyboard();
  }

  void hideKeyboard() {
    try {
      SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    } catch (e) {}
  }

  void showLoading([
    bool condition = true,
    String tag = '',
  ]) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!condition) return;
    if (!mounted) return;
    isShowLoading = true;

    try {
      var notifier = ref.read(
          loadingProvider(tag.isEmpty ? runtimeType.toString() : tag).notifier);
      if (notifier.mounted) notifier.update((state) => true);
    } catch (e) {
      log('Lỗi showloading: ${e.toString()}');
    }
  }

  void hideLoading([
    String tag = '',
  ]) {
    if (!mounted) return;
    isShowLoading = false;
    var notifier = ref.read(
        loadingProvider(tag.isEmpty ? runtimeType.toString() : tag).notifier);
    if (notifier.mounted) notifier.update((state) => false);
  }

  Future<bool> handleResponse<M>(ApiResponse<M?>? result, Function(M?) response,
      {Function(AppException?)? error}) async {
    if (!mounted) return false;
    if (result != null) {
      if (result.status == Status.complete) {
        if (mounted) {
          response.call(result.data);
        }
        return true;
      } else {
        await exceptionThrow(result.exception);
        if (mounted) {
          error?.call(result.exception);
        }
        return false;
      }
    } else {
      var exception = AppException('Có lỗi xảy ra, vui lòng thử lại sau!');
      await exceptionThrow(exception);
      if (mounted) {
        error?.call(exception);
      }
      return false;
    }
  }

  Future<bool> exceptionThrow(AppException? exception) async {
    if (mounted) {
      await DialogUtils.showMessageDialog(context,
          exception?.message ?? 'Có lỗi xảy ra, vui lòng thử lại sau!');
      if (exception?.code == StatusCode.kTokenExpired) {
        //Token hết hạn
        ref.read(appController.notifier).logOut();
      }
    }
    return false;
  }

  Future<void> showMessageDialog(String message,
      {String title = 'Thông báo'}) async {
    return DialogUtils.showMessageDialog(context, message, title: title);
  }

  void handleLoadMore(int itemSize) {
    if (itemSize == AppConstants.pageSize) {
      pageIndex++;
      isAvailableLoadMore = true;
    } else {
      isAvailableLoadMore = false;
    }
  }

  void refreshData() async {
    pageIndex = 1;
    isAvailableLoadMore = true;
  }

  Future<void> onSelectDate(
    BuildContext context,
    TextEditingController controller, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    var result = await showDatePickerSelect(context, controller.text,
        firstDate: firstDate, lastDate: lastDate);
    if (result != null) {
      controller.text = result.toStringFormat();
    }
  }

  Future<DateTime?> showDatePickerSelect(
    BuildContext context,
    String currentDate, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    if (currentDate.isEmpty) currentDate = DateTime.now().toStringFormat();

    return await showDatePicker(
      context: context,
      initialDate: dateFromString(currentDate),
      locale: const Locale('vi'),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2040),
    );
  }

  DateTime dateFromString(String dateString, [String format = defaultFormat]) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      log('String to date error: $e');
      return DateTime.now();
    }
  }

  ///Dùng để show Loading khi mở Dialog
  void showLoadingDialog() async {
    if (!mounted) return;
    if (isShowLoadingDialog) return;
    isShowLoadingDialog = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingWidget(),
          ),
        );
      },
      routeSettings: const RouteSettings(name: 'loadingDialog'),
    );
    isShowLoadingDialog = false;
  }

  void hideLoadingDialog() {
    if (isShowLoadingDialog) {
      Navigator.of(context).pop();
    }
  }

  Future<List<XFile>> pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlxs',
        'png',
        'jpg',
        'jpeg',
      ],
    );
    if (result != null) {
      // All files
      final xFiles = result.files
          .map((f) =>
              XFile(f.path!, name: f.name, bytes: f.bytes, length: f.size))
          .toList();
      return xFiles;
    } else {
      return [];
    }
  }
}
