import 'package:get/get.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../views/controller/certificate_controller.dart';
import '../../../views/i18n/generated_locales/l10n.dart';
import '../../../views/widgets/dialog/common_dialog.dart';
import 'generate_cer_key/index.dart';

class CommonActionCertificate {
  static goActiveCer(CertificateModel certificateModel,
      {Function? callBackGetTo}) async {
    Get.to(() => GenerateCerKeyPage(certificateModel: certificateModel))
        ?.then((value) {
      callBackGetTo?.call();
    });
  }

  static showDialogActiveCerOtherDevice(
      CertificateModel certificateModel) async {
    showNotifyModal(AppLocalizations.current.notifActiveCerOtherDevice,
        onlyActionCancel: false,
        titleBtnAccept: AppLocalizations.current.confirm,
        titleBtnCancel: AppLocalizations.current.iUnderstand, actionAccept: () {
      if (certificateModel.serial == null) {
        return;
      }

      final controller = Get.isRegistered<CertificateController>()
          ? Get.find<CertificateController>()
          : Get.put(CertificateController());

      controller.requestChangeDevice(
          id: certificateModel.id, serial: certificateModel.serial!);
    });
  }
}
