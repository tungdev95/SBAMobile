// import 'package:bms/services/api/token_auth_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sba/src/models/assets/assets.dart';

void main() {
  test('function test', () async {
    // final number = 10.235;
    // expect(number.format3Number(), 10.235);
    List<LegalModel> legalInformationsFromJson(
        List<Map<String, dynamic>>? lsItem) {
      return (lsItem ?? []).mapIndexed((index, e) {
        return LegalModel.fromJson(e);
      }).toList()
        ..sort((a, b) => (a.orderBy ?? 0).compareTo(b.orderBy ?? 0));
    }

    final json = [
      LegalModel(orderBy: 2).toJson(),
      LegalModel(orderBy: 5).toJson(),
      LegalModel(orderBy: 8).toJson(),
      LegalModel(orderBy: 4).toJson(),
      LegalModel(orderBy: 0).toJson(),
    ];
    final result =
        legalInformationsFromJson(json).map((e) => e.orderBy ?? 0).toList();
    final okResult = [0, 2, 4, 5, 8];
    expect(result, okResult);
  });
}
