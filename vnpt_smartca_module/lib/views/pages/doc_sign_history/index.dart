// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables

import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/views/controller/app_controller.dart';
import 'package:vnpt_smartca_module/views/controller/auth_controller.dart';
import 'package:vnpt_smartca_module/views/controller/home_controller.dart';
import 'package:vnpt_smartca_module/views/utils/color.dart';
import '../../../core/models/request/history_request_model.dart';
import '../../../core/models/response/certificate_model.dart';
import '../../../core/models/response/transaction_model.dart';
import '../../../gen/assets.gen.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../theme/styles.dart';
import '../../widgets/app_refresh.dart';
import '../../widgets/dialog/modal_bottom_sheet.dart';
import '../../widgets/widget.dart';
import '../../../core/extensions/datetime.dart';

import '../home/widgets/doc_sign_history.dart';

class ListDocSignHistoryPage extends StatefulWidget {
  final CertificateModel? certificateModel;

  const ListDocSignHistoryPage({Key? key, this.certificateModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListDocSignatureHistoryState();
}

class _ListDocSignatureHistoryState extends State<ListDocSignHistoryPage> {
  final AppRefreshController appRefreshController = AppRefreshController();
  HistoryRequestModel historyRequestModel =
      HistoryRequestModel(order: 'InitialDate', isDesc: true);
  var keySearchController = TextEditingController();
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  @override
  void initState() {
    super.initState();

    historyRequestModel.startDate = historyRequestModel.startDate == null
        ? DateTime.now().add(Duration(days: -1 * 8))
        : historyRequestModel.startDate!;

    historyRequestModel.endDate = historyRequestModel.endDate == null
        ? DateTime.now()
        : historyRequestModel.endDate!;

    var startDate = historyRequestModel.startDate?.fromDate();
    var endDate = historyRequestModel.endDate?.fromDate();

    startDateController = TextEditingController(text: startDate);
    endDateController = TextEditingController(text: endDate);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: AppLocalizations.current.docSignatureHistory,
        body: Container(
          color: const Color(0xFFF4F6FB),
          child: Column(
            children: [
              renderFilter(),
              Container(
                height: 4,
                color: AppColors.white,
              ),
              Expanded(
                child: AppRefresh<TransactionModel>(
                  path: "/csc/signature/his",
                  fromMap: TransactionModel.fromMap,
                  headerBuilder: (int? length) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context).result,
                          style: TextStyle(
                            color: Color(0xff08285C),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  " ${AppLocalizations.of(context).totalResult(length ?? 0)}",
                              style: TextStyle(
                                color: Color(0xff44507B),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  params: historyRequestModel.toMap(),
                  appRefreshController: appRefreshController,
                  filter: (value) {
                    final currentUser = Get.find<AuthController>().currentUser;
                    if (currentUser.value?.accType == 1) {
                      try {
                        final deviceId = Get.find<AppController>()
                            .deviceInfo
                            .value
                            ?.deviceId;

                        final listCertActivedOnDevice =
                            Get.find<HomeController>()
                                    .listCertificate
                                    .value
                                    ?.where((element) =>
                                        element.device?.deviceID == deviceId)
                                    .map((e) => e.id) ??
                                [];

                        return listCertActivedOnDevice
                            .contains(value.credentialId);
                      } catch (e) {}
                    }
                    return true;
                  },
                  itemWidgetBuilder: (value, index) {
                    return DocSignatureHistoryWidget(value: value);
                  },
                  isLoadMore: true,
                  itemSpace: 8,
                ),
              )
            ],
          ),
        ));
  }

  final inputDecoration = (String hintText,
          {Widget? suffixIcon, Color? fillColor, bool enabled = true}) =>
      InputDecoration(
          isDense: true,
          labelText: hintText,
          enabled: enabled,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          labelStyle: const TextStyle(color: Color(0xffA5B0C2), fontSize: 14),
          hintStyle: const TextStyle(color: Color(0xffA5B0C2), fontSize: 14),
          fillColor: fillColor ?? Color(0xffF2F6FA),
          suffixIconConstraints: BoxConstraints(maxWidth: 40),
          suffixIcon: suffixIcon);

  renderFilter() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 14, top: 6, bottom: 6),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: renderBaseTextInput(
              title: AppLocalizations.of(context).fromDate,
              child: InkWell(
                onTap: () {
                  CustomBottomSheetDialog.showDatePicker(
                    context,
                    maximumDate: DateTime.now(),
                    initialDate: historyRequestModel.startDate,
                  ).then((value) {
                    if (value != null) {
                      var difference = value
                          .difference(historyRequestModel.endDate!)
                          .inDays
                          .abs();

                      if (difference > 3 * 30 || value > historyRequestModel.endDate!) {
                        var futureDate = value.add(Duration(days: 3 * 30));

                        if (futureDate <= DateTime.now()) {
                          historyRequestModel.endDate = futureDate;
                        } else {
                          historyRequestModel.endDate = DateTime.now();
                        }

                        endDateController.text =
                            historyRequestModel.endDate!.fromDate();
                      }

                      historyRequestModel.startDate = value;
                      startDateController.text =
                          historyRequestModel.startDate?.fromDate() ?? "";
                    }
                  });
                },
                child: TextField(
                  enabled: false,
                  controller: startDateController,
                  textInputAction: TextInputAction.done,
                  decoration: inputDecoration(
                      AppLocalizations.of(context).selectDate,
                      suffixIcon: Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Assets.images.icCalendar.image(width: 20))),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: renderBaseTextInput(
              title: AppLocalizations.of(context).toDate,
              child: InkWell(
                onTap: () {
                  CustomBottomSheetDialog.showDatePicker(
                    context,
                    maximumDate: DateTime.now(),
                    initialDate: historyRequestModel.endDate,
                  ).then((value) {
                    if (value != null) {
                      var difference = value
                          .difference(historyRequestModel.startDate!)
                          .inDays
                          .abs();
                      if (difference > 3 * 30 || value < historyRequestModel.startDate!) {
                        historyRequestModel.startDate =
                            value.add(Duration(days: -3 * 30));

                        startDateController.text =
                            historyRequestModel.startDate!.fromDate();
                      }

                      historyRequestModel.endDate = value;
                      endDateController.text =
                          historyRequestModel.endDate?.fromDate() ?? "";
                    }
                  });
                },
                child: TextField(
                  enabled: false,
                  controller: endDateController,
                  textInputAction: TextInputAction.done,
                  decoration: inputDecoration(
                      AppLocalizations.of(context).selectDate,
                      suffixIcon: Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Assets.images.icCalendar.image(width: 20))),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var inputFormat = DateFormat('dd/MM/yyyy');
              historyRequestModel.startDate =
                  inputFormat.parse(startDateController.value.text);
              historyRequestModel.endDate =
                  inputFormat.parse(endDateController.value.text);
              appRefreshController.refresh(params: historyRequestModel.toMap());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              height: 42,
              decoration: BoxDecoration(
                color: Color(0xff0D75D6).withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.search_outlined,
                color: Color(0xff0D75D6),
              ),
            ),
          ),
        ],
        // FormBuilderTextField(
        //   name: "",
        //   onSubmitted: (value) {
        //     setState(() {
        //       historyRequestModel.keySearch = value;
        //     });
        //   },
        //   controller: keySearchController,
        //   textInputAction: TextInputAction.done,
        //   decoration: inputDecoration(
        //     AppLocalizations.current.inputNameDoc,
        //     fillColor: Colors.white,
        //     suffixIcon: IconButton(
        //       onPressed: () {},
        //       icon: Assets.images.icSearch.image(width: 20),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Row(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         showDialogFilter().then((value) {
        //           if (value is HistoryRequestModel) {
        //             setState(() {
        //               historyRequestModel = value;
        //               keySearchController.text =
        //                   this.historyRequestModel.keySearch ?? "";
        //             });
        //           }
        //         });
        //       },
        //       child: Row(
        //         children: [
        //           Assets.images.icFilter.image(width: 20),
        //           const SizedBox(width: 10),
        //           BaseText(
        //             AppLocalizations.of(context).searchAdvance,
        //             color: const Color(0xff0D75D6),
        //             fontWeight: FontWeight.w600,
        //             fontSize: 14,
        //           ),
        //         ],
        //       ),
        //     ),
        //     const SizedBox(width: 40),
        //     Expanded(
        //       child: Container(
        //         child: AppButtonWidget(
        //           label: AppLocalizations.of(context).search,
        //           onTap: () {
        //             setState(() {});
        //           },
        //         ),
        //       ),
        //     )
        //   ],
        // )
      ),
    );
  }

  Widget renderBaseTextInput({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 6),
            child: BaseText(
              title,
              color: Color(0xff08285C),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          child
        ],
      ),
    );
  }

  Future showDialogFilter() {
    HistoryRequestModel historyRequestModel = HistoryRequestModel(
        order: this.historyRequestModel.order,
        startDate: this.historyRequestModel.startDate,
        endDate: this.historyRequestModel.endDate,
        isDesc: this.historyRequestModel.isDesc,
        keySearch: keySearchController.text,
        certificateModel: this.historyRequestModel.certificateModel);

    var textSeachController =
        TextEditingController(text: historyRequestModel.keySearch ?? "");
    var cerController = TextEditingController(
        text: historyRequestModel.certificateModel?.serial ?? "");
    return CustomBottomSheetDialog.show(
        isScrollControlled: true,
        title: AppLocalizations.of(context).searchAdvance,
        childBuilder: (context) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                renderBaseTextInput(
                    title: AppLocalizations.of(context).nameDoc,
                    child: TextField(
                      controller: textSeachController,
                      onChanged: (text) {
                        historyRequestModel.keySearch = text;
                      },
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.done,
                      decoration: inputDecoration(
                        AppLocalizations.current.inputNameDoc,
                      ),
                    )),
                // TODO @nambuidanh hanlde select cer
                renderBaseTextInput(
                  title: AppLocalizations.of(context).certificate,
                  child: InkWell(
                    onTap: () {},
                    child: TextField(
                      enabled: false,
                      controller: cerController,
                      textInputAction: TextInputAction.done,
                      decoration: inputDecoration(
                          AppLocalizations.of(context).selectCertificate,
                          suffixIcon: Container(
                              color: Color(0xffF2F6FA),
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff5768A5),
                                size: 20,
                              ))),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                AppButtonWidget(
                  label: AppLocalizations.of(context).search,
                  onTap: () {
                    Navigator.pop(context, historyRequestModel);
                  },
                ),
              ],
            ),
          );
        });
  }
}
