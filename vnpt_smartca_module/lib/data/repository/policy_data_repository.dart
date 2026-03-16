import 'package:dartz/dartz.dart';
import 'package:vnpt_smartca_module/core/models/app/exceptions.dart';
import 'package:vnpt_smartca_module/core/models/response/service_response.dart';
import '../../core/models/response/policy_data_response.dart';
import '../network/policy_data_api.dart';

class PolicyDataRepository {
  final PolicyDataApi remoteDataSource;

  PolicyDataRepository(this.remoteDataSource);

  Future<Either<GenericException, PolicyDataResponse?>> getPolicy(
      String uid) async {
    try {
      final remoteData = await remoteDataSource.getPolicy(uid);
      return remoteData.code == 0
          ? Right(remoteData.content != ""
              ? PolicyDataResponse.fromJson(remoteData.content)
              : null)
          : Left(GenericException(
              error: ServerException(
              message: remoteData.message,
              code: remoteData.code,
              codeDesc: remoteData.codeDesc,
            )));
    } catch (e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }

  Future<Either<GenericException, SmartCAApiResponse>> updatePolicy(
      String uid, List<ND13Content> nd13content) async {
    try {
      final remoteData = await remoteDataSource.updatePolicy(uid, nd13content);
      return remoteData.code == 0
          ? Right(remoteData)
          : Left(GenericException(
              error: ServerException(
              message: remoteData.message,
              code: remoteData.code,
              codeDesc: remoteData.codeDesc,
            )));
    } catch (e, s) {
      return Left(GenericException(error: e, stack: s));
    }
  }
}
