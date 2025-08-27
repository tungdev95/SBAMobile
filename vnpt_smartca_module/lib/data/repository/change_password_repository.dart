import 'package:dartz/dartz.dart';

import '../../core/models/app/exceptions.dart';
import '../network/change_password_api.dart';

class ChangePasswordRepository {
  final ChangePasswordApi remoteDataSource;

  ChangePasswordRepository(this.remoteDataSource);

  Future<Either<GenericException, bool>> changePassword(String currentPassword, String newPassword) async {
    try {
      final remoteData = await remoteDataSource.changePassword(currentPassword, newPassword);
      return remoteData.code == 0
          ? Right(true)
          : Left(
              GenericException(
                error: ServerException(
                  message: remoteData.message,
                  code: remoteData.code,
                  codeDesc: remoteData.codeDesc,
                ),
              ),
            );
    } catch (e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }
}
