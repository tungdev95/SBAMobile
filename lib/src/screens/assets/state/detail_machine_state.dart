// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';

class DetailMachineState extends BaseDetailItemState {
  MachineInfo machineInfo;

  DetailMachineState({
    required this.machineInfo,
    required super.expandList,
  });

  @override
  List<Object?> get props => [machineInfo.id];

  @override
  DetailMachineState copyWith({
    List<ExpandModel>? expandList,
    MachineInfo? machineInfo,
  }) {
    return DetailMachineState(
      expandList: expandList ?? this.expandList,
      machineInfo: machineInfo ?? this.machineInfo,
    );
  }
}
