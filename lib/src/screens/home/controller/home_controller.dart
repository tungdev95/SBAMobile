import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/home/main_page.dart';
import 'package:sba/src/screens/home/states/home_state.dart';

class HomePageController extends BaseController<HomeState> {
  HomePageController(super.state, super.ref);

  static final assetWaitingCompleteProvider =
      StateNotifierProvider.autoDispose<HomePageController, HomeState>(
    (ref) {
      final lsMenu = [
        AssetMenuModel<AssetGenImage>(
          id: AssetsTypeEnum.taiSan,
          title: 'Tài sản',
          imageName: '',
          image: Assets.images.icTaisan,
          notiCount: 0,
        ),
        AssetMenuModel<AssetGenImage>(
          id: AssetsTypeEnum.taoToTrinh,
          title: 'Tạo tờ trình',
          imageName: '',
          image: Assets.images.icTaototrinh,
          notiCount: 0,
        ),
        AssetMenuModel<AssetGenImage>(
          id: AssetsTypeEnum.toTrinh,
          title: 'Tờ trình',
          imageName: '',
          image: Assets.images.icTotrinh,
          notiCount: 0,
        ),
        AssetMenuModel<AssetGenImage>(
          id: AssetsTypeEnum.doanDuong,
          title: 'Đoạn đường',
          imageName: '',
          image: Assets.images.icDoanduong,
          notiCount: 0,
        ),
      ];
      return HomePageController(HomeState(listMenuData: lsMenu), ref);
    },
  );

  void onMenuClicked(AssetsTypeEnum id) {
    if (id == AssetsTypeEnum.taiSan) {
      ref.read(homePageDataProvider.notifier).focusTaiSan();
    } else {
      showMessageDialog('Tính năng đang phát triển, vui lòng quay lại sau!');
    }
  }
}
