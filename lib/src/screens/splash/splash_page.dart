import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/home/main_page.dart';
import 'package:sba/src/screens/login/login_page.dart';
import 'package:sba/src/utils/utils.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashState();
}

class _SplashState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4397D4),
              Color(0xFF4165B1),
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Hero(
                tag: "splash_image",
                child: Assets.images.icSba.svg(
                  width: context.screenSize.width * 0.5,
                ),
              ),
              // child: Text(
              //   'SBA Mobile',
              //   style: context.textTheme.titleLarge?.copyWith(
              //     fontWeight: FontWeight.w700,
              //     color: Colors.white,
              //     fontSize: 30,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  void checkUserLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    var user = ref.read(appController).userLogin;
    if (user != null && user.accessToken != null) {
      AppRoutes.pushReplacement(context, const MainPage(), name: 'MainPage');
      // AppRoutes.pushReplacement(
      //   context,
      //   ProviderScope(
      //     overrides: [
      //       assetsDetailProvider.overrideWithValue(
      //         AssetsModel(
      //           appraisalFileId: '71bb4087-e7eb-400d-967d-45b80c9788ad',
      //           proposalCode: 'SBA.24.000858',
      //           assetType: AssetsTypeEnum.mmtb,
      //           reportCode: 'PM.000164/24/ĐS-MTS',
      //           customerId: 'eb9c4c72-6342-469e-b067-4c1f2e93b892',
      //           assetLevelThreeId: 41,
      //           surveySchedules: [],
      //         ),
      //       )
      //     ],
      //     child: const MMTBDetailPage(),
      //   ),
      // );
    } else {
      AppRoutes.pushReplacement(context, const LoginPage());
    }
  }
}
