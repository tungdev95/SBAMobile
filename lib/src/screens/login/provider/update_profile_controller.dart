// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sba/src/screens/base/controller/base_controller.dart';
// import 'package:sba/src/screens/login/provider/login_states.dart';
// import 'package:sba/src/services/api/user_api.dart';

// class UpdateProfileController extends BaseController<LoginState> {
//   UpdateProfileController(Ref ref) : super(LoginState(), ref);

//   static final updateProfileProvider =
//       StateNotifierProvider.autoDispose<UpdateProfileController, LoginState>(
//           (ref) => UpdateProfileController(ref));

//   // final loginFormKey = GlobalKey<FormState>();

//   bool validateForm() {
//     // if (validateData.value == false) validateData.sink.add(true);
//     // return loginFormKey.currentState?.validate() ?? false;
//     return false;
//   }

//   Future<bool> updateProfile(String ho, String ten, String userId) async {
//     showLoading();
//     var loginResult =
//         await ref.read(userApiProvider).userUpdateProfile(ho, ten, userId);
//     hideLoading();
//     return await handleResponse(loginResult, (data) {});
//   }
// }
