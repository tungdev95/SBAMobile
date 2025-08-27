class ApiResponse<T> {
  AppException? exception;
  T? data;
  Status status;
  ApiResponse.completed(this.data) : status = Status.complete;
  ApiResponse.error(this.exception) : status = Status.error;
  ApiResponse.login() : status = Status.redirect;

  bool get isSuccess => status == Status.complete;

  @override
  String toString() {
    return 'Status : $status \n Message : ${exception?.message} \n Data : $data';
  }
}

class AppException implements Exception {
  final String? message;
  final int? code;

  AppException([this.message, this.code]);

  @override
  String toString() {
    return '$message';
  }
}

class InvalidPathException implements AppException {
  @override
  String get message => 'Thông tin Api không hợp lệ';

  @override
  int get code => StatusCode.k404;
}

class TokenExpiredException implements AppException {
  @override
  String get message => 'Phiên làm việc hết hạn, vui lòng đăng nhập lại!';

  @override
  int get code => StatusCode.kTokenExpired;
}

// class MultipleConnectException implements AppException {
//   @override
//   get code => StatusCode.MULTIPLE_DEVICE_CONNECT;
//
//   @override
//   get message => throw UnimplementedError();
// }

class ServerConnectException implements AppException {
  @override
  String get message => 'Không thể kết nối tới máy chủ, vui lòng thử lại sau!';

  @override
  int get code => StatusCode.kConnectServerError;
}

class ActionTimeoutException implements AppException {
  @override
  String get message => 'Hết thời gian xử lý, vui lòng thử lại';

  @override
  int get code => StatusCode.kOtherError;
}

class StatusCode {
  static const int kSuccess = 0;
  static const int k404 = 404;
  static const int kTokenExpired = 403;
  static const int kConnectServerError = 104;
  static const int kOtherError = 1;
}

enum Status { loading, complete, error, redirect }
