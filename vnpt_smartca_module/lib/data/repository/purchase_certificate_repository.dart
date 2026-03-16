import 'package:dartz/dartz.dart';
import '../../../core/models/app/exceptions.dart';
import '../../../data/network/purchase_certificate_api.dart';

class PurchaseCertificateRepository {
  final PurchaseCertificateApi remoteDataSource;

  PurchaseCertificateRepository(this.remoteDataSource);

  getCertPackages() async {
    try {
      final remoteData = await remoteDataSource.getCertificatePacks("");
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0
          ? Right(remoteData.content)
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

  createPersonalCertificateOrder(dynamic dataItems, String accessToken) async {
    try {
      final remoteData = await remoteDataSource.createPersonalCertificateOrder(
          dataItems, accessToken);
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0
          ? Right(remoteData.content)
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

  initPersonalCertificateOrderTransaction(String id, String maGt) async {
    try {
      final remoteData = await remoteDataSource
          .initPersonalCertificateOrderTransactionV2(id, maGt);
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0 ||
              remoteData.code == 60015 // 60015: tra ve model order
          ? Right(remoteData.content)
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

  checkOrderPaymentResult(String accessToken, String id, String responseCode,
      String secureCode, String localityCode) async {
    try {
      final remoteData = await remoteDataSource.checkOrderPaymentResult(
          accessToken, id, responseCode, secureCode, localityCode);
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0
          ? Right(remoteData.content)
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

  getProvince() async {
    try {
      final remoteData = await remoteDataSource.getProvinces("");
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0
          ? Right(remoteData.content)
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

  getAllWards() async {
    try {
      final remoteData = await remoteDataSource.getAllWards();
      // final resp = TransactionHistoryRespModel.fromMap(remoteData.content);
      return remoteData.code == 0
          ? Right(remoteData.content)
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
