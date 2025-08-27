import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/map/states/map_state.dart';
import 'package:sba/src/utils/utils.dart';
import '../../models/base/base.dart';
import '../../widgets/widget_search.dart';
import 'controller/map_controller.dart';

final mapPageProvider = Provider<MapPageData>((ref) {
  // if (lastKnowPosition != null) {
  //   return LatLng(lastKnowPosition!.latitude, lastKnowPosition!.longitude);
  // }
  // return null;
  throw UnimplementedError();
});

// ignore: must_be_immutable
class MapPage extends BasePage<MapController, MapState> {
  LatLng? defaultLatLng;
  // late MapApi _mapApi;
  // List<dynamic> listItem = [];
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  MapPage({Key? key, this.defaultLatLng}) : super(key: key);

  @override
  String get title => S.current.dinh_vi;

  @override
  AutoDisposeStateNotifierProvider<MapController, MapState> provider(ref) =>
      MapController.mapControllerProvider(ref.read(mapPageProvider));

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
    MapState state,
  ) {
    var searchFocus = useFocusNode();
    defaultLatLng ??=
        LatLng(lastKnowPosition!.latitude, lastKnowPosition!.longitude);
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: ref.read(provider(ref).notifier).onMapCreated,
          padding: EdgeInsets.only(
            top: kToolbarHeight + context.padding.top + 16,
          ),
          initialCameraPosition:
              CameraPosition(target: defaultLatLng!, zoom: 18.0),
          markers: state.marker != null ? {state.marker!} : {},
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (newPosition) {
            ref.read(provider(ref).notifier).updateCameraPosition(newPosition);
          },
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              context.textNormal.copyWith(color: Colors.black),
                        ),
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          ref
                              .read(provider(ref).notifier)
                              .updateAddressText(item['description'] as String);
                          getDetailFromPlaceId(ref.read(provider(ref).notifier),
                              item['place_id'], ref);
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

  void getSuggestion(MapController notifier, String input) async {
    notifier.getSuggestion(input);
  }

  void getDetailFromPlaceId(
      MapController notifier, String placeId, WidgetRef ref) async {
    LatLng? response = await notifier.getDetailFromPlaceId(placeId);

    if (response != null) {
      ref.read(provider(ref).notifier).setNewLocation(response);
    }
  }
}
