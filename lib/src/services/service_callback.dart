import '../models/base/base_api_model.dart';

abstract class ServicesCallBack {
  void onError(AppException? exception);
}
