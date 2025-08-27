// import 'dart:convert';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/maps/map_detail_model.dart';
import 'package:sba/src/services/base_api_services.dart';

const kGoogleApiKey = "AIzaSyBBu9RRF-riHA_A0mDI14-37tXAKT5EIQI";

final mapApiProvider = Provider.autoDispose<MapApi>((ref) {
  var result = MapApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class MapApi extends BaseApi {
  MapApi(super.dio);

  Future<List<dynamic>> getSuggestion(
    String input,
    String sessionToken,
  ) async {
    //
    String request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:VN&language=vi&key=$kGoogleApiKey&price_level=0&sessiontoken=$sessionToken';
    var response = await dio.get(request,
        cancelToken: mapCancelToken[request] ??= CancelToken());
    mapCancelToken[request] = null;

    if (response.statusCode == 200) {
      return response.data['predictions'];
    } else {
      return [];
    }
  }

  Future<LatLng?> getLocationFromInput(
    String input,
    String sessionToken,
  ) async {
    //
    String request =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$input&components=country:VN&language=vi&key=$kGoogleApiKey&price_level=0&sessiontoken=$sessionToken';
    var response = await dio.get(request,
        cancelToken: mapCancelToken[request] ??= CancelToken());
    mapCancelToken[request] = null;
    if (response.statusCode == 200) {
      final location = (response.data['results'] as List<dynamic>)
          .firstOrNull?['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      return null;
    }
  }

  Future<LatLng?> getDetailFromPlaceId(
    String placeId,
    String sessionToken,
  ) async {
    String request =
        'https://maps.googleapis.com/maps/api/place/details/json?key=$kGoogleApiKey&place_id=$placeId&sessiontoken=$sessionToken';
    var response = await dio.get(request,
        cancelToken: mapCancelToken[request] ??= CancelToken());
    mapCancelToken[request] = null;
    if (response.statusCode == 200) {
      var rs =
          MapDetailModel.fromJson(response.data['result']).geometry?.location;
      return LatLng(rs?.lat ?? 0.0, rs?.lng ?? 0.0);
    } else {
      return null;
    }
  }

  Future<String> getLocationCityName(
    String latLng,
    String sessionToken,
  ) async {
    String request =
        'https://maps.googleapis.com/maps/api/geocode/json?key=$kGoogleApiKey&latlng=$latLng&sessiontoken=$sessionToken';
    var response = await dio.get(request,
        cancelToken: mapCancelToken[request] ??= CancelToken());
    mapCancelToken[request] = null;
    if (response.statusCode == 200) {
      return response.data['results'][0]['address_components'][3]['long_name'];
    } else {
      return '';
    }
  }

  Future<String> getLocationName(
    String latLng,
    String sessionToken,
  ) async {
    String request =
        'https://maps.googleapis.com/maps/api/geocode/json?key=$kGoogleApiKey&latlng=$latLng&sessiontoken=$sessionToken';
    var response = await dio.get(request,
        cancelToken: mapCancelToken[request] ??= CancelToken());
    mapCancelToken[request] = null;
    if (response.statusCode == 200) {
      return response.data['results'][0]['formatted_address'];
    } else {
      return '';
    }
  }
}
