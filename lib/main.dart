import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/helper/digital_sign.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/chcc_info.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/assets/ptdb_model.dart';
import 'package:sba/src/models/assets/ptdt_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/maps/maps.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sba_app.dart';
import 'package:hive/hive.dart';
import 'package:vnpt_smartca_module/main.dart';

@pragma('vm:entry-point')
void VNPTSmartCAEntryponit() => bootstrapSmartCAApp();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences share = await SharedPreferences.getInstance();
  DigitalSign.instance.initSDK();

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  Hive.registerAdapter(
      'AppendixPendingModel', AssetsDetailModel<RealEstateModel>.fromJson);
  Hive.registerAdapter(
      'ChCCDetailModel', AssetsDetailModel<CHCCModel>.fromJson);
  Hive.registerAdapter(
      'PTDBDetailModel', AssetsDetailModel<PTDBModel>.fromJson);
  Hive.registerAdapter(
      'MMTBDetailModel', AssetsDetailModel<MMTBModel>.fromJson);
  Hive.registerAdapter(
      'PTDTDetailModel', AssetsDetailModel<PTDTModel>.fromJson);
  Hive.registerAdapter('DuAnModel', AssetsDetailModel<DuAnModel>.fromJson);
  Hive.registerAdapter('ConstructionModel', ConstructionModel.fromJson);
  Hive.registerAdapter('FileUploadModel', FileUploadModel.fromJson);
  Hive.registerAdapter('LocalLatLng', LocalLatLng.fromJson);
  Hive.registerAdapter('SurveyDetailData', SurveyDetailData.fromJson);
  Hive.registerAdapter('KeyValueModel', KeyValueModel.fromJson);
  Hive.registerAdapter('RiskFactorModel', RiskFactorModel.fromJson);
  Hive.registerAdapter('RiskAssetModel', RiskAssetModel.fromJson);
  Hive.registerAdapter('KeyValueModel', KeyValueModel.fromJson);
  Hive.registerAdapter('RealEstateModel', RealEstateModel.fromJson);
  Hive.registerAdapter('CHCCModel', CHCCModel.fromJson);
  Hive.registerAdapter('CHCCInfo', CHCCInfo.fromJson);
  Hive.registerAdapter('LandingPurposeModel', LandingPurposeModel.fromJson);
  Hive.registerAdapter(
      'ConstructionFutureInfo', ConstructionFutureInfo.fromJson);
  Hive.registerAdapter('TreeModel', TreeModel.fromJson);

  Box<AssetsDetailModel<RealEstateModel>> bdsBox =
      Hive.box<AssetsDetailModel<RealEstateModel>>(name: 'bdsBox');
  Box<AssetsDetailModel<CHCCModel>> chccBox =
      Hive.box<AssetsDetailModel<CHCCModel>>(name: 'chccBox');
  Box<AssetsDetailModel<PTDBModel>> ptdbBox =
      Hive.box<AssetsDetailModel<PTDBModel>>(name: 'ptdbBox');
  Box<AssetsDetailModel<MMTBModel>> mmtbBox =
      Hive.box<AssetsDetailModel<MMTBModel>>(name: 'mmtbBox');
  Box<AssetsDetailModel<PTDTModel>> ptdtBox =
      Hive.box<AssetsDetailModel<PTDTModel>>(name: 'ptdtBox');
  Box<AssetsDetailModel<DuAnModel>> duAnBox =
      Hive.box<AssetsDetailModel<DuAnModel>>(name: 'duAnBox');
  Box<String> assetSaved = Hive.box<String>(name: 'assetSaved');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) {
      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(share),
            bdsBoxProvider.overrideWithValue(bdsBox),
            chccBoxProvider.overrideWithValue(chccBox),
            ptdbBoxProvider.overrideWithValue(ptdbBox),
            mmtbBoxProvider.overrideWithValue(mmtbBox),
            ptdtBoxProvider.overrideWithValue(ptdtBox),
            duAnBoxProvider.overrideWithValue(duAnBox),
            assetSavedProvider.overrideWithValue(assetSaved),
          ],
          child: const SBAApp(),
        ),
      );
    },
  );
}
