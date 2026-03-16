import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/dinhgianhanh/state/dinhgianhanh_map_state.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/utils.dart';
import '../../models/base/base.dart';
import '../../utils/uuid.dart';
import '../../widgets/widget_search.dart';
import 'controller/dinhgianhanh_map_controller.dart';

final detailDinhGiaItem = Provider.autoDispose<FastValuationModel>((ref) {
  throw UnimplementedError();
});

// ignore: must_be_immutable
class DinhGiaNhanhMapPage
    extends BasePage<DinhGiaNhanhMapController, DinhGiaNhanhMapState> {
  String sessionToken = Uuid().generateV4();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  DinhGiaNhanhMapPage({super.key});

  @override
  String get title => S.current.dinh_vi;

  @override
  AutoDisposeStateNotifierProvider<DinhGiaNhanhMapController,
      DinhGiaNhanhMapState> provider(
          ref) =>
      DinhGiaNhanhMapController.mapControllerProvider(
          ref.read(detailDinhGiaItem));

  @override
  List<Widget>? actionWidget(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () async {
          ref.read(provider(ref).notifier).saveMapLocation(context);
        },
      )
    ];
  }

  @override
  Widget bodyWidget(
    BuildContext context,
    WidgetRef ref,
    DinhGiaNhanhMapState state,
  ) {
    var searchFocus = useFocusNode();

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: ref.read(provider(ref).notifier).onMapCreated,
          padding: EdgeInsets.only(
            bottom: context.padding.bottom,
            top: kToolbarHeight + context.padding.top + 16,
          ),
          initialCameraPosition:
              CameraPosition(target: state.center, zoom: 18.0),
          circles: state.circle ?? {},
          markers: state.listMarker.toSet(),
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          // indoorViewEnabled: true,
          mapToolbarEnabled: true,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          // onCameraMove: _updateCameraPosition,
          onTap: (position) {
            ref.read(provider(ref).notifier).onMapTapped(position);
          },
          gestureRecognizers: {}
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()),
            ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              SearchWidget(
                focus: searchFocus,
                controller: ref.read(provider(ref).notifier).searchController,
                hint: S.current.nhap_dia_chi_ten_duong,
                onChanged: (value) {
                  _debouncer.run(
                    () {
                      getSuggestion(ref.read(provider(ref).notifier), value);
                    },
                  );
                },
              ),
              if (state.listItem.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = state.listItem[index];
                      return ListTile(
                        title: Text(
                          item['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              context.textMedium.copyWith(color: Colors.black),
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          ref
                              .read(provider(ref).notifier)
                              .searchController
                              .text = '';
                          getDetailFromPlaceId(ref.read(provider(ref).notifier),
                              item['place_id'], item['description']);
                        },
                      );
                    },
                    itemCount: state.listItem.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 0,
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  void getSuggestion(DinhGiaNhanhMapController notifier, String input) async {
    notifier.getSuggestion(input, sessionToken);
  }

  void getDetailFromPlaceId(
      DinhGiaNhanhMapController notifier, String placeId, String desc) async {
    LatLng? response =
        await notifier.getDetailFromPlaceId(placeId, sessionToken, desc);
    // if (response != null) mapState.currentState?.setNewLocation(response);
  }
}
