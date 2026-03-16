import 'dart:convert';
import '../../extensions/datetime.dart';

import '../response/certificate_model.dart';

class HistoryRequestModel {
  String? order;
  bool? isDesc;
  DateTime? startDate = DateTime.now().add(Duration(days: -30));
  DateTime? endDate = DateTime.now();
  String? keySearch;
  CertificateModel? certificateModel;
  int? page;
  int? pageSize;

  HistoryRequestModel(
      {this.order,
      this.isDesc,
      this.startDate,
      this.endDate,
      this.keySearch,
      this.certificateModel,
      this.page,
      this.pageSize});

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'isDesc': isDesc,
      "startDate": (startDate ?? DateTime.now().add(Duration(days: -30)))
              .dateFormatEN() +
          "T00:00:00",
      "endDate":
          (endDate ?? DateTime.now()).dateFormatEN() + "T23:59:59.999999",
      "keySearch": keySearch,
      "cerId": certificateModel?.id,
      "page": page,
      "pageSize": pageSize,
    };
  }

  String toJson() => json.encode(toMap());
}
