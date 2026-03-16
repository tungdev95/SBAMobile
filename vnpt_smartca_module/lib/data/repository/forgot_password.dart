import 'package:dartz/dartz.dart';
import 'package:vnpt_smartca_module/core/models/app/exceptions.dart';
import 'package:vnpt_smartca_module/core/models/response/service_response.dart';
import 'package:vnpt_smartca_module/data/network/forgot_password.dart';
import 'package:vnpt_smartca_module/views/i18n/generated_locales/intl/messages_vi.dart';

class ForgotPasswordRepository {
  final ForgotPasswordApi remoteDataSource;

  ForgotPasswordRepository(this.remoteDataSource);

  Future<Either<GenericException, SmartCAApiResponse>> resetPasswordWithOtp(dynamic param) async {
    try {
      final remoteData = await remoteDataSource.resetPasswordWithOtp(param);
      return remoteData.code == 0
          ? Right(remoteData)
          : Left(
            GenericException(
              error: ServerException(
                message: remoteData.message, 
                code: remoteData.code,
                codeDesc: remoteData.codeDesc,
                ),
              ),
          );
    }
    catch (e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }

  Future<Either<GenericException, SmartCAApiResponse>> getInfo(dynamic param) async {
    try {
      final remoteData = await remoteDataSource.getInfo(param);
      return remoteData.code == 0
          ? Right(remoteData)
          : Left(
            GenericException(
              error: ServerException(
                message: remoteData.message, 
                code: remoteData.code,
                codeDesc: remoteData.codeDesc,
              ),
            ),
          );
    }
    catch(e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }

  Future<Either<GenericException, SmartCAApiResponse>> getOTP(dynamic param) async {
    try {
      final remoteData = await remoteDataSource.getOTP(param);
      return remoteData.code == 0 
          ? Right(remoteData)
          : Left(
            GenericException(
              error: ServerException(
                message: remoteData.message, 
                code: remoteData.code,
                codeDesc: remoteData.codeDesc
              ),
            ),
          );
    }
    catch(e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }
}