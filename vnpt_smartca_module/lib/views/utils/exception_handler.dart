import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/models/app/exceptions.dart';
import '../i18n/generated_locales/l10n.dart';

import '../../configs/injector/injector.dart';
import '../../data/repository/send_log_repository.dart';

String exceptionHandler(GenericException failure) {
  Object error = failure.error;
  // final stack = failure.stack;
  final iSendLogRepository = getIt<SendLogRepository>();

  if (error is ServerException) {
    iSendLogRepository.sendLog(
        "${error.codeDesc ?? error.codeDesc.toString()}  ${error.message}");
  } else if (error is DioException) {
    iSendLogRepository
        .sendLog("${error.requestOptions.path} - ${error.toString()}");
  } else {
    iSendLogRepository.sendLog(error.toString());
  }

  if (kDebugMode) {
    // var logger = Logger();
    // logger.d(error);
    // if (stack != null) logger.e(stack);
  }
  try {
    switch (error.runtimeType) {
      case DioException:
        String message = "";
        error = (error as DioException);
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            message = AppLocalizations.current.connectTimeout;
            break;
          case DioExceptionType.connectionError:
            message = AppLocalizations.current.serviceLostConnection;
            break;
          default:
            if ((error.response?.statusCode ?? -1) >= 500) {
              message =
                  "${AppLocalizations.current.serviceSomethingWentWrong}\n(st ${error.response?.statusCode})";
            } else {
              message = error.response != null &&
                      error.response!.data.toString().isNotEmpty
                  ? error.response!.data['message'] ??
                      error.response!.data['title'] ??
                      error.response!.data['detail'] ??
                      error.response!.data['error_description'] ??
                      error.response!.data['error'] ??
                      error.response!.data['errors']
                          .toString()
                          .replaceAll("{", "")
                          .replaceAll("}", "") ??
                      error.message ??
                      error.toString()
                  : error.message;
            }
        }

        return message == ""
            ? AppLocalizations.current.serviceSomethingWentWrong
            : message;
      case NoInternetException:
        return AppLocalizations.current.noInternet;
      case ServerException:
        var message = (error as ServerException).message;
        if (message?.trim() == "null") {
          message = AppLocalizations.current.serviceSomethingWentWrong;
        }
        return message;
      default:
        var message = error.toString();
        if (message?.trim() == "null") {
          message = AppLocalizations.current.serviceSomethingWentWrong;
        }
        return message;
    }
  } catch (e) {
    iSendLogRepository.sendLog(e.toString());
    return error.toString();
  }
}
