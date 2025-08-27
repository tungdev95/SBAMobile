// import 'package:sba/src/services/api/user_api.dart';

// import '../../models/base/base_api_model.dart';
// import '../../models/login/user_model.dart';

// class UserApiFake extends UserApi {
//   // UserApiFake(super.dio);

//   // @override
//   // Future<ApiResponse<UserModel?>> login(String userName, String pass) async {
//   //   try {
//   //     var response = ApiResponse.completed(
//   //       UserModel(
//   //           userName: userName,
//   //           firstName: 'Khieu',
//   //           lastName: 'Nguyen',
//   //           token: 'fakeToken',
//   //           departmentName: 'Chi nhánh SBA - Sài Gòn',
//   //           avatar:
//   //               'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1380&t=st=1693468247~exp=1693468847~hmac=75b59dbb809361ad800dacc7b4c35f905392033be81bc02a61c8b77cc2aba621'),
//   //     );
//   //     if (response.status == Status.complete) {
//   //       response.data =
//   //           response.data?.copyWith(pass: pass, loginName: userName);
//   //     }
//   //     return response;
//   //     // return ApiResponse.completed(UserModel(firstName: 'Khieu', lastName: 'khieu'));
//   //   } catch (error) {
//   //     return ApiResponse.error(
//   //       AppException(
//   //         error.toString(),
//   //       ),
//   //     );
//   //   }
//   // }

//   @override
//   Future<ApiResponse<UserModel?>> logOut() async {
//     return ApiResponse.completed(null);
//   }

//   @override
//   Future<ApiResponse<dynamic>> userUpdateProfile(
//     String ho,
//     String ten,
//     String userId,
//   ) async {
//     return ApiResponse.completed(true);
//     // try {
//     //   final response = await createPostRequest<dynamic>(_userUpdateProfile,
//     //       data: {"FirstName": ten, "LastName": ho, "UserId": userId});
//     //   return response;
//     // } catch (error) {
//     //   return ApiResponse.error(AppException(error.toString()));
//     // }
//   }
// }
