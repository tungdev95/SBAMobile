import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/chcc_model.dart';
import 'package:sba/src/models/assets/duan_model.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/assets/ptdb_model.dart';
import 'package:sba/src/models/assets/ptdt_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:sba/src/screens/base/controller/app_controller.dart';
import 'package:sba/src/screens/base/controller/app_states.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// UserModel? currentUser = null;

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

// final appProvider = StateProvider<auth.AppState?>(
//   (ref) {
//     return const auth.AppState.initial();
//   },
//   dependencies: [sharedPreferencesProvider],
// );

final appController = StateNotifierProvider<AppController, AppState>(
  (ref) {
    try {
      final sharedPreferences = ref.watch(sharedPreferencesProvider);
      LanguageModel? language;
      var oldLanguage = sharedPreferences.getString('language');
      if (oldLanguage != null) {
        language = LanguageModel.initWithCode(jsonDecode(oldLanguage));
      }
      UserModel? user;
      var oldUserString = sharedPreferences.getString('user');
      if (oldUserString != null) {
        user = UserModel.fromJson(jsonDecode(oldUserString));
      }
      return AppController(
        AppState(
          language: language ?? const LanguageModel(),
          userLogin: user,
        ),
        ref,
      );
    } catch (e) {
      return AppController(AppState(), ref);
    }
  },
  dependencies: [sharedPreferencesProvider, dioProvider],
);

final Provider<Box<AssetsDetailModel<RealEstateModel>>> bdsBoxProvider =
    Provider<Box<AssetsDetailModel<RealEstateModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<AssetsDetailModel<CHCCModel>>> chccBoxProvider =
    Provider<Box<AssetsDetailModel<CHCCModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<AssetsDetailModel<PTDBModel>>> ptdbBoxProvider =
    Provider<Box<AssetsDetailModel<PTDBModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<AssetsDetailModel<MMTBModel>>> mmtbBoxProvider =
    Provider<Box<AssetsDetailModel<MMTBModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<AssetsDetailModel<PTDTModel>>> ptdtBoxProvider =
    Provider<Box<AssetsDetailModel<PTDTModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<AssetsDetailModel<DuAnModel>>> duAnBoxProvider =
    Provider<Box<AssetsDetailModel<DuAnModel>>>((ref) {
  throw UnimplementedError();
});

final Provider<Box<String>> assetSavedProvider = Provider<Box<String>>((ref) {
  throw UnimplementedError();
});
