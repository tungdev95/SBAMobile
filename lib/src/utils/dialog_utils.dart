import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static bool isDialogShowing = false;
  static Completer? dialogCompleter;

  static Future<void> showMessageDialog(BuildContext? context, String messgae,
      {String? title = 'Thông báo'}) async {
    if (context == null) {
      return;
    }
    if (dialogCompleter != null) {
      return dialogCompleter?.future;
    }
    dialogCompleter = Completer();
    showAlertDialog(
      context: context,
      message: messgae,
      title: title,
      actions: [
        const AlertDialogAction(key: 'ok', label: 'OK', isDefaultAction: true)
      ],
    ).then(
      (value) {
        dialogCompleter?.complete();
        dialogCompleter = null;
      },
    );
    // isDialogShowing = false;
    return dialogCompleter?.future;
  }

  static Future<dynamic> showConfirmDialog(BuildContext context, String messgae,
      {String? title = 'Thông báo'}) async {
    if (dialogCompleter != null) {
      return dialogCompleter?.future;
    }
    dialogCompleter = Completer();
    showOkCancelAlertDialog(
      context: context,
      message: messgae,
      title: title,
    ).then(
      (value) {
        dialogCompleter?.complete(value);
        dialogCompleter = null;
      },
    );
    // isDialogShowing = false;
    return dialogCompleter?.future;
  }
}
