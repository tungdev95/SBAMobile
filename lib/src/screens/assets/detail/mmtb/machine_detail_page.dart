import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/mmtb/machine_detail_page_controller.dart';
import 'package:sba/src/screens/assets/state/detail_machine_state.dart';

final machineProvider = Provider.autoDispose<MachineInfo>((ref) {
  throw UnimplementedError();
});

class MachineDetailPage extends BaseDetailInfoPage<DetailMachineState,
    MachineDetailPageController> {
  const MachineDetailPage({super.key});

  @override
  String get title => 'Đặc điểm kỹ thuật';

  @override
  AutoDisposeStateNotifierProvider<MachineDetailPageController,
      DetailMachineState> provider(WidgetRef ref) {
    return MachineDetailPageController.machineDetail(ref.read(machineProvider));
  }
}
