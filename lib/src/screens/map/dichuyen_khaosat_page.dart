// import 'package:adaptive_dialog/adaptive_dialog.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/src/consumer.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mb_amc/src/screens/base/base_page.dart';
// import 'package:mb_amc/src/screens/map/controller/dichuyen_khaosat_controller.dart';
// import 'package:mb_amc/src/utils/utils.dart';
// import 'package:riverpod/src/state_notifier_provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

// import 'states/dichuyen_khaosat_state.dart';

// class DiChuyenKhaoSatPage
//     extends BasePage<DiChuyenKhaoSatController, DiChuyenKhaoSatState> {
//   const DiChuyenKhaoSatPage({Key? key}) : super(key: key);

//   @override
//   AutoDisposeStateNotifierProvider<DiChuyenKhaoSatController,
//       DiChuyenKhaoSatState> provider(
//           WidgetRef ref) =>
//       DiChuyenKhaoSatController.diChuyenKhaoSatProvider;

//   @override
//   Widget bodyWidget(
//     BuildContext context,
//     WidgetRef ref,
//     DiChuyenKhaoSatState state,
//   ) {
//     var maxHeight = MediaQuery.of(context).size.height * .35;
//     var minHeight = 100.0;
//     var notifier = ref.watch(provider(ref).notifier);
//     return WillPopScope(
//       child: Stack(
//         children: [
//           SlidingUpPanel(
//             controller: notifier.panelController,
//             maxHeight: maxHeight,
//             minHeight: minHeight,
//             parallaxEnabled: true,
//             parallaxOffset: .5,
//             panelBuilder: (sc) {
//               return _panel(context, ref, sc, notifier, state);
//             },
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(18.0),
//               topRight: Radius.circular(18.0),
//             ),
//             onPanelSlide: (double pos) {
//               notifier.updateFabHeight(pos * (maxHeight - minHeight) + 120);
//             },
//             body: Container(
//               margin: const EdgeInsets.only(
//                 bottom: 90.0,
//               ),
//               child: GoogleMap(
//                 onMapCreated: (controller) {
//                   onMapCreated(controller, notifier, state);
//                 },
//                 initialCameraPosition: notifier.position,
//                 markers: state.markers.toSet(),
//                 polylines: (state.polylines ?? {}).values.toSet(),
//                 scrollGesturesEnabled: true,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: false,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: false,
//                 compassEnabled: false,
//                 onCameraMove: notifier.updateCameraPosition,
//                 gestureRecognizers: {}
//                   ..add(
//                     Factory<PanGestureRecognizer>(
//                       () => PanGestureRecognizer(),
//                     ),
//                   )
//                   ..add(
//                     Factory<ScaleGestureRecognizer>(
//                       () => ScaleGestureRecognizer(),
//                     ),
//                   )
//                   ..add(
//                     Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
//                   )
//                   ..add(
//                     Factory<VerticalDragGestureRecognizer>(
//                       () => VerticalDragGestureRecognizer(),
//                     ),
//                   ),
//               ),
//             ),
//           ),
//           searchBox(context, notifier, state),
//           Positioned(
//             right: 20.0,
//             bottom: state.fabHeight,
//             child: FloatingActionButton(
//               heroTag: 'current_location',
//               backgroundColor: Colors.white,
//               child: const Icon(
//                 Icons.my_location,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 notifier.focusToCurrentPosition();
//               },
//             ),
//           )
//         ],
//       ),
//       onWillPop: () async {
//         return true;
//       },
//     );
//   }

//   Widget _panel(
//     BuildContext context,
//     WidgetRef ref,
//     ScrollController sc,
//     DiChuyenKhaoSatController notifier,
//     DiChuyenKhaoSatState state,
//   ) {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         controller: sc,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Vị trí khảo sát',
//               style: context.textLargeMedium,
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             Container(
//               color: Colors.transparent,
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.person_pin_sharp,
//                     color: AppColor.secondaryColor,
//                   ),
//                   const SizedBox(
//                     width: 16.0,
//                   ),
//                   Expanded(
//                     child: Text(
//                       state.assetDetail.contactPerson ?? 'Chưa có thông tin',
//                       style: context.textMediumMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             GestureDetector(
//               onTap: () {
//                 notifier.makePhoneCall();
//               },
//               child: Container(
//                 color: Colors.transparent,
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.phone,
//                       color: AppColor.secondaryColor,
//                     ),
//                     const SizedBox(
//                       width: 16.0,
//                     ),
//                     Expanded(
//                       child: Text(
//                         state.assetDetail.contactNumber ?? 'Chưa có thông tin',
//                         style: context.textMediumMedium,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             GestureDetector(
//               onTap: () {
//                 ref
//                     .read(provider(ref).notifier)
//                     .moveToDesPosition(context, state.surveyDetailData);
//               },
//               child: Container(
//                 color: Colors.transparent,
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.my_location,
//                       color: AppColor.secondaryColor,
//                     ),
//                     const SizedBox(
//                       width: 16.0,
//                     ),
//                     Expanded(
//                       child: Text(
//                         state.surveyDetailData?.desAddress ??
//                             'Chưa có thông tin',
//                         style: context.textMediumMedium,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Container(
//               color: Colors.transparent,
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.timeline,
//                     color: AppColor.secondaryColor,
//                   ),
//                   const SizedBox(
//                     width: 16.0,
//                   ),
//                   Expanded(
//                     child: Text(
//                       'Tổng quãng đường: ${(state.distanceInMeters / 1000).toPriceFormat()}km',
//                       style: context.textMediumMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             if (state.surveyDetailData?.begin == false)
//               Row(
//                 children: [
//                   TextButton.icon(
//                     onPressed: () async {
//                       await notifier.findWay(context);
//                       // setState(() {});
//                     },
//                     style: TextButton.styleFrom(
//                         backgroundColor: AppColor.primaryColor),
//                     icon: const Icon(Icons.timeline),
//                     label: const Text('Đường đi'),
//                   ),
//                   const SizedBox(width: 8.0),
//                   TextButton.icon(
//                     onPressed: () async {
//                       await notifier.panelController.close();
//                       var surveyDetail = state.surveyDetailData;
//                       await notifier.startSurvey(context, surveyDetail);
//                       notifier.updateDetail(surveyDetail);
//                       notifier.toggleExpand();
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: AppColor.primaryColor,
//                     ),
//                     icon: const Icon(Icons.directions_bike_outlined),
//                     label: const Text('Bắt đầu khảo sát'),
//                   )
//                 ],
//               )
//             else
//               Row(
//                 children: [
//                   TextButton.icon(
//                     onPressed: () async {
//                       await notifier.panelController.close();
//                       notifier.toggleExpand();
//                       var pinEndLocation =
//                           await notifier.pinEndLocation(context);
//                       // setState(() {});

//                       if (pinEndLocation) {
//                         await notifier.endSurvey(context);
//                       }
//                     },
//                     style: TextButton.styleFrom(
//                         backgroundColor: AppColor.primaryColor),
//                     icon: const Icon(Icons.directions_bike_outlined),
//                     label: const Text('Kết thúc chuyến đi'),
//                   )
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void onMapCreated(
//     GoogleMapController controller,
//     DiChuyenKhaoSatController notifier,
//     DiChuyenKhaoSatState state,
//   ) async {
//     await notifier.onMapCreated(controller);
//     // setState(() {});

//     if (state.surveyDetailData?.isFinish == true) {
//       await showOkAlertDialog(
//         context: useContext(),
//         title: 'Thông báo',
//         message: 'Chuyến đi đã kết thúc!',
//       );
//       Navigator.of(useContext()).pop();
//     }
//   }

//   Widget searchBox(
//     BuildContext context,
//     DiChuyenKhaoSatController notifier,
//     DiChuyenKhaoSatState state,
//   ) {
//     return AnimatedPositioned(
//       duration: const Duration(milliseconds: 200),
//       top: state.isExpand
//           ? 0
//           : -(104 + MediaQuery.of(context).padding.top + 16 + 32),
//       left: 0,
//       child: Container(
//         margin: EdgeInsets.only(
//           left: 16.0,
//           right: 16.0,
//           top: MediaQuery.of(context).padding.top + 16,
//         ),
//         width: MediaQuery.of(context).size.width - 32,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0.0, 3.0),
//               blurRadius: 8,
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 104,
//               margin: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: notifier.startLocation,
//                     enabled: false,
//                     decoration: const InputDecoration(
//                       contentPadding: EdgeInsets.all(8.0),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       labelText: 'Vị trí bắt đầu',
//                       suffixIcon: Icon(
//                         Icons.my_location,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8.0,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       var surveyDetail = state.surveyDetailData;
//                       await notifier.showSearchLocationPage(
//                           context, surveyDetail);
//                       notifier.updateDetail(surveyDetail);
//                       // setState(() {});
//                     },
//                     child: TextField(
//                       controller: notifier.desLocation,
//                       enabled: false,
//                       decoration: const InputDecoration(
//                         contentPadding: EdgeInsets.all(8.0),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         labelText: 'Vị trí khảo sát',
//                         suffixIcon: Icon(
//                           Icons.add_location,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [],
//                   )
//                 ],
//               ),
//             ),
//             Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       top: state.isExpand
//                           ? 0
//                           : MediaQuery.of(context).padding.top,
//                     ),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         notifier.toggleExpand();
//                       },
//                       padding: EdgeInsets.zero,
//                       icon: Icon(
//                         state.isExpand ? Icons.expand_less : Icons.expand_more,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.only(
//                       top: state.isExpand
//                           ? 0
//                           : MediaQuery.of(context).padding.top,
//                     ),
//                     decoration: const BoxDecoration(),
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       padding: EdgeInsets.zero,
//                       icon: const Icon(Icons.close),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
