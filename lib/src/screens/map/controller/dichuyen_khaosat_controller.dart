// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:mb_amc/src/screens/base/base_controller.dart';
// import 'package:google_geocoding/google_geocoding.dart' as geo;
// import 'dart:async';
// import 'dart:math';

// import 'package:adaptive_dialog/adaptive_dialog.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart' as place;
// import 'package:mb_amc/src/screens/base/base_page.dart';
// import 'package:mb_amc/src/screens/home/base_assets_page.dart';
// import 'package:mb_amc/src/services/api/minute_api.dart';
// import 'package:mb_amc/src/services/file_service.dart';
// import 'package:mb_amc/src/utils/utils.dart';
// import 'package:google_maps_webservice/src/core.dart' as googleService;
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../models/base/base.dart';
// import '../../../models/maps/maps.dart';
// import '../../../services/api/map_api.dart';
// import '../../../utils/uuid.dart';
// import '../states/dichuyen_khaosat_state.dart';

// class DiChuyenKhaoSatController extends BaseController<DiChuyenKhaoSatState> {
//   var googleGeocoding = geo.GoogleGeocoding(kGoogleApiKey);
//   CameraPosition position = const CameraPosition(
//     target: LatLng(21.028511, 105.804817),
//     zoom: 11.0,
//   );
//   var panelController = PanelController();
//   bool isExpand = true;
//   GoogleMapController? controller;
//   LatLng? userLocation;
//   LatLng? center;
//   late TextEditingController startLocation;
//   late TextEditingController desLocation;
//   StreamSubscription? positionStream;
//   var polylinePoints = PolylinePoints();

//   DiChuyenKhaoSatController(DiChuyenKhaoSatState state, Ref ref)
//       : super(state, ref) {
//     startLocation = TextEditingController();
//     desLocation = TextEditingController();
//     startUpdateLocation();
//   }

//   static final diChuyenKhaoSatProvider = StateNotifierProvider.autoDispose<
//       DiChuyenKhaoSatController, DiChuyenKhaoSatState>((ref) {
//     var assetsDetail = ref.watch(currentDetailModelProvider);
//     return DiChuyenKhaoSatController(
//       DiChuyenKhaoSatState(assetDetail: assetsDetail),
//       ref,
//     );
//   }, dependencies: [
//     currentDetailModelProvider,
//     loadingProvider,
//     minuteApiProvider,
//     fileServiceProvider,
//     mapApiProvider
//   ]);

//   Future<String> getLocationDetail(String latLng, String sessionToken) async {
//     return ref.read(mapApiProvider).getLocationCityName(latLng, sessionToken);
//   }

//   void startUpdateLocation() {
//     positionStream = Geolocator.getPositionStream(
//         // desiredAccuracy: LocationAccuracy.high,
//         // distanceFilter: defaultTargetPlatform == TargetPlatform.iOS ? 5 : 2,
//         locationSettings: LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: defaultTargetPlatform == TargetPlatform.iOS ? 5 : 2,
//     )).listen(
//       (Position position) async {
//         userLocation = LatLng(position.latitude, position.longitude);
//         if (state.surveyDetailData?.begin == true) {
//           //Kiểm tra lại logic chỗ này
//           // setStopMarker(userLocation!);
//         }
//       },
//     );
//   }

//   onMapCreated(GoogleMapController controller) async {
//     if (!mounted) {
//       return;
//     }
//     this.controller = controller;
//     await getSurveyDetail();
//   }

//   ///Lấy chi tiết di chuyển
//   getSurveyDetail() async {
//     showLoading();
//     var assetDetail = state.assetDetail;
//     var result = await ref
//         .read(minuteApiProvider)
//         .getMovingDetail(minutesID: assetDetail.id ?? '');
//     hideLoading();
//     var isOk = await handleResponse(result, (SurveyDetailData? data) async {});
//     if (isOk != true) {
//       await getInitialLocation();
//     } else {
//       var data = result.data;
//       if (data != null && data.startLocation != null) {
//         //Chuyến đi đã bắt đầu
//         // var oldDetailData = detailBox.get(assetDetail.id);
//         data.begin = true;
//         state = state.copyWith.call(surveyDetailData: data);
//         await setDefaultData(data);
//         //Chưa có dữ liệu quãng đường di chuyển, bắt đầu tìm đường
//         if ((data.doanDuong ?? '').isEmpty) {
//           drawPolylines(data);
//         } else {
//           var decodedPolyline = NetworkUtil()
//               .decodeEncodedPolyline(data.doanDuong ?? '')
//               .map((e) => LatLng(e.latitude, e.longitude))
//               .toList();
//           onlyDrawPolylines(decodedPolyline);
//         }
//         updateDetail(data);
//       } else {
//         await getInitialLocation();
//       }
//     }
//   }

//   //Chuyến đi đã bắt đầu, set default
//   setDefaultData(SurveyDetailData surveyDetailData) async {
//     userLocation ??= await getUserLocation();
//     if (userLocation == null) {
//       await showOkAlertDialog(
//           context: context,
//           message: 'Không thể lấy vị trí hiện tại, vui lòng tải lại trang!');
//       Navigator.of(context).pop();
//     }
//     if (userLocation != null) setNewLocation(userLocation!);
//     startLocation.text = surveyDetailData.startAddress ?? '';
//     desLocation.text = surveyDetailData.desAddress ?? '';
//     setStartMarker(surveyDetailData);
//     setEndMarker(surveyDetailData);
//     await drawPolylines(surveyDetailData);
//     // if ((surveyDetailData.listPoint ?? []).isNotEmpty) await drawPolylines();
//   }

//   ///Chuyến đi chưa bắt đầu, khởi tạo dữ liệu
//   getInitialLocation() async {
//     var surveyDetailData = state.surveyDetailData ?? SurveyDetailData();
//     desLocation.text = state.assetDetail.mortgageAssetAddress ?? '';
//     userLocation ??= await getUserLocation();
//     if (userLocation == null) {
//       await showOkAlertDialog(
//           context: context,
//           message: 'Không thể lấy vị trí hiện tại, vui lòng tải lại trang!');
//       Navigator.of(context).pop();
//     }
//     if (userLocation != null) {
//       setNewLocation(userLocation!);
//       await Future.delayed(const Duration(seconds: 1));
//       surveyDetailData.startLocation = LocalLatLng(
//           '${userLocation?.latitude ?? 0.0}',
//           '${userLocation?.longitude ?? 0.0}');
//       surveyDetailData.desAddress = state.assetDetail.mortgageAssetAddress;
//       if (surveyDetailData.startAddress == null) {
//         await getStartAddress(surveyDetailData);
//         setStartMarker(surveyDetailData);
//       }
//       if (surveyDetailData.desLocation == null) {
//         var desLocation =
//             await getLocationFromAddress(surveyDetailData.desAddress)
//                 .timeout(const Duration(seconds: 5))
//                 .catchError((error) => null);
//         if (desLocation != null) {
//           surveyDetailData.desLocation = LocalLatLng(
//               '${desLocation.latitude}', '${desLocation.longitude}');
//           setEndMarker(surveyDetailData);
//         }
//       }
//     }
//     updateDetail(surveyDetailData);
//   }

//   void updateCameraPosition(CameraPosition position) {
//     this.position = position;
//     center = position.target;
//   }

//   focusToCurrentPosition() async {
//     userLocation ??= await getUserLocation();
//     if (userLocation != null) setNewLocation(userLocation!);
//   }

//   ///Lấy location user hiện tại
//   Future<LatLng?> getUserLocation() async {
//     try {
//       // if (userLocation != null) return userLocation;
//       var position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         forceAndroidLocationManager: true,
//         timeLimit: const Duration(seconds: 10),
//       );
//       return LatLng(position.latitude, position.longitude);
//     } catch (e) {
//       if (userLocation != null) return userLocation;
//       return null;
//     }
//   }

//   ///Lấy tọa độ từ địa chỉ khảo sát
//   Future<Location?> getLocationFromAddress(String? address) async {
//     try {
//       if ((address ?? '').isEmpty) return null;
//       geo.GeocodingResponse? location = await googleGeocoding.geocoding
//           .get(address ?? '', [], language: 'vi');
//       var result = location?.results?.first.geometry?.location; //first;
//       if (result != null) {
//         return Location(
//           latitude: result.lat ?? 0.0,
//           longitude: result.lng ?? 0.0,
//           timestamp: DateTime.now(),
//         );
//       }
//       return null;
//     } catch (e) {
//       // print(e);
//       return null;
//     }
//   }

//   ///Lấy tọa độ khảo sát
//   Future getStartAddress(SurveyDetailData? surveyDetailData) async {
//     try {
//       geo.GeocodingResponse? location =
//           await googleGeocoding.geocoding.getReverse(
//         geo.LatLon(
//           userLocation?.latitude ?? 0.0,
//           userLocation?.longitude ?? 0.0,
//         ),
//         language: 'vi',
//       );
//       var result = location?.results?.first.formattedAddress;
//       surveyDetailData?.startAddress = result;
//       startLocation.text = surveyDetailData?.startAddress ?? '';
//     } catch (e) {
//       print(e);
//     }
//   }

//   ///Sau khi có toạ độ mới, focus map vào toạ độ này
//   setNewLocation(LatLng value) {
//     controller?.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: value, zoom: 18)));
//   }

//   ///Pin start marker
//   void setStartMarker(SurveyDetailData surveyDetailData) {
//     var startCoordinates = surveyDetailData.startLocation;
//     if (startCoordinates == null) return;
//     Marker startMarker = Marker(
//       markerId: const MarkerId('startMarker'),
//       position: LatLng(
//         startCoordinates.getLatLng().latitude,
//         startCoordinates.getLatLng().longitude,
//       ),
//       infoWindow: InfoWindow(
//         title: 'Điểm bắt đầu',
//         snippet: surveyDetailData.startAddress,
//       ),
//       icon: BitmapDescriptor.defaultMarker,
//     );
//     state = state.copyWith.call(markers: [...state.markers, startMarker]);
//   }

//   ///Pin end marker
//   void setEndMarker(SurveyDetailData surveyDetailData) {
//     var destinationCoordinates = surveyDetailData.desLocation;
//     if (destinationCoordinates == null) return;
//     Marker destinationMarker = Marker(
//       markerId: const MarkerId('desMarker'),
//       position: LatLng(
//         destinationCoordinates.getLatLng().latitude,
//         destinationCoordinates.getLatLng().longitude,
//       ),
//       infoWindow: InfoWindow(
//         title: 'Điểm kết thúc',
//         snippet: surveyDetailData.desAddress,
//       ),
//       icon: BitmapDescriptor.defaultMarker,
//     );
//     state = state.copyWith.call(markers: [...state.markers, destinationMarker]);
//   }

//   ///Pin stop marker
//   void setStopMarker(LatLng currentLatLng) {
//     Marker stopMarker = Marker(
//       markerId: const MarkerId('stopMarker'),
//       position: LatLng(
//         currentLatLng.latitude,
//         currentLatLng.longitude,
//       ),
//       zIndex: 3,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//     );
//     state = state.copyWith.call(markers: [...state.markers, stopMarker]);
//   }

//   ///Zoom out map để thấy các điểm
//   zoomOutCameraToShowAllPoint(
//       LatLng? startCoordinates, LatLng? destinationCoordinates) async {
//     if (startCoordinates == null) return;
//     if (destinationCoordinates == null) return;

//     // Accommodate the two locations within the
//     // camera view of the map
//     return await controller?.animateCamera(
//       CameraUpdate.newLatLngBounds(
//         getBounds([startCoordinates, destinationCoordinates]),
//         100.0, // padding
//       ),
//     );
//   }

//   ///Tính khoảng cách lớn nhất
//   LatLngBounds getBounds(List<LatLng> markers) {
//     var lngs = markers.map<double>((m) => m.longitude).toList();
//     var lats = markers.map<double>((m) => m.latitude).toList();

//     double topMost = lngs.reduce(max);
//     double leftMost = lats.reduce(min);
//     double rightMost = lats.reduce(max);
//     double bottomMost = lngs.reduce(min);

//     LatLngBounds bounds = LatLngBounds(
//       northeast: LatLng(
//         rightMost,
//         topMost,
//       ),
//       southwest: LatLng(
//         leftMost,
//         bottomMost,
//       ),
//     );

//     return bounds;
//   }

//   ///Vẽ đường đi
//   Future<bool> drawPolylines(SurveyDetailData? surveyDetailData) async {
//     if (surveyDetailData == null) return false;
//     if (state.polylines?.isNotEmpty == true) return false;
//     if (surveyDetailData.startLocation == null ||
//         surveyDetailData.desLocation == null) return false;
//     showLoading();
//     var startLocation = surveyDetailData.startLocation?.getLatLng();
//     var desLocation = surveyDetailData.desLocation?.getLatLng();
//     List<LatLng> polylineCoordinates =
//         await createPolylines(startLocation!, desLocation!, surveyDetailData);
//     double totalDistance = 0.0;

//     // Calculating the total distance by adding the distance
//     // between small segments
//     for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//       totalDistance += Geolocator.distanceBetween(
//         polylineCoordinates[i].latitude,
//         polylineCoordinates[i].longitude,
//         polylineCoordinates[i + 1].latitude,
//         polylineCoordinates[i + 1].longitude,
//       );
//     }
//     onlyDrawPolylines(polylineCoordinates);
//     hideLoading();
//     state = state.copyWith.call(distanceInMeters: totalDistance);
//     return true;
//   }

//   ///Xoá đường đi
//   removePolylines() {
//     // mapData.sink.add(mapData.value?.copyWith());
//     state = state.copyWith.call(polylines: {});
//   }

//   // Create the polylines for showing the route between two places
//   createPolylines(LatLng start, LatLng destination,
//       SurveyDetailData surveyDetailData) async {
//     List<LatLng> polylineCoordinates = [];
//     // Initializing PolylinePoints
//     removePolylines();

//     // var polylinePoints = PolylinePoints();

//     // Generating the list of coordinates to be used for
//     // drawing the polylines
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       kGoogleApiKey, // Google Maps API Key
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       travelMode: TravelMode.driving,
//     );

//     // Adding the coordinates to the list
//     if (result.points.isNotEmpty) {
//       surveyDetailData.doanDuong = result.waypoints;
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }

//     return polylineCoordinates;
//   }

//   ///Vẽ polylines
//   onlyDrawPolylines(List<LatLng> polylineCoordinates) async {
//     // Defining an ID
//     PolylineId id = PolylineId('${DateTime.now().millisecondsSinceEpoch}');

//     // Initializing Polyline
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.red,
//       points: polylineCoordinates,
//       width: 5, // set the width of the polylines
//     );

//     // Adding the polyline to the map
//     state = state.copyWith(
//         polylines: Map.from(state.polylines ?? {})..[id] = polyline);
//   }

//   void moveToDesPosition(
//       BuildContext context, SurveyDetailData? surveyDetailData) async {
//     if (surveyDetailData == null) return;
//     if (surveyDetailData.desLocation != null) {
//       setNewLocation(surveyDetailData.desLocation!.getLatLng());
//     } else {
//       var desLocation =
//           await getLocationFromAddress(surveyDetailData.desAddress)
//               .timeout(const Duration(seconds: 3))
//               .catchError((error) => null);
//       if (desLocation != null) {
//         surveyDetailData.desLocation =
//             LocalLatLng('${desLocation.latitude}', '${desLocation.longitude}');
//         setNewLocation(surveyDetailData.desLocation!.getLatLng());
//       } else {
//         showMessageAndGotoFindAddressPage(context);
//       }
//     }
//   }

//   ///Hiển thị trang tìm kiếm địa chỉ
//   Future<place.Prediction?> showSearchLocationPage(
//       BuildContext context, SurveyDetailData? surveyDetailData) async {
//     assert(userLocation != null);
//     if (surveyDetailData?.begin == true) return null;
//     place.Prediction? p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       types: [],
//       mode: Mode.fullscreen,
//       language: 'vi',
//       radius: 100000,
//       location: userLocation != null
//           ? googleService.Location(
//               lat: userLocation?.latitude ?? 0.0,
//               lng: userLocation?.longitude ?? 0.0,
//             )
//           : null,
//       strictbounds: false,
//       sessionToken: Uuid().generateV4(),
//       startText: state.surveyDetailData?.desAddress ?? '',
//       decoration: const InputDecoration(
//         hintText: 'Nhập điểm đến...',
//         border: InputBorder.none,
//       ),
//       region: 'VN',
//       components: [
//         place.Component(place.Component.country, 'VN'),
//       ],
//     );
//     if (p != null) {
//       await _getLatLng(p, surveyDetailData);
//       return p;
//     }
//     return null;
//   }

//   _getLatLng(
//       place.Prediction? prediction, SurveyDetailData? surveyDetailData) async {
//     if (surveyDetailData == null) return;
//     place.GoogleMapsPlaces _places = place.GoogleMapsPlaces(
//       apiKey: kGoogleApiKey,
//     );
//     place.PlacesDetailsResponse? detail =
//         await _places.getDetailsByPlaceId(prediction?.placeId ?? '');
//     double? latitude = detail.result.geometry?.location.lat;
//     double? longitude = detail.result.geometry?.location.lng;
//     String address = prediction?.description ?? '';
//     surveyDetailData.desAddress = address;
//     surveyDetailData.desLocation = LocalLatLng(
//       '${latitude ?? 0.0}',
//       '${longitude ?? 0.0}',
//     );
//     desLocation.text = address;
//     state = state.copyWith.call(distanceInMeters: 0);
//     setEndMarker(surveyDetailData);
//     setNewLocation(surveyDetailData.desLocation!.getLatLng());
//     removePolylines();
//   }

//   ///Bắt đầu khảo sát
//   startSurvey(BuildContext context, SurveyDetailData? surveyDetailData) async {
//     if (surveyDetailData == null) return;
//     if (surveyDetailData.startLocation == null) {
//       await showOkAlertDialog(
//           context: context,
//           message:
//               'Không tìm thấy vị trí bắt đầu, vui lòng kiểm tra lại định vị và thử lại sau!');
//       Navigator.of(context).pop();
//       return;
//     }
//     if (state.distanceInMeters == 0) {
//       await drawPolylines(surveyDetailData);
//       if (state.distanceInMeters == 0) {
//         await showOkAlertDialog(
//           context: context,
//           title: 'Thông báo',
//           message: 'Không tìm thấy vị trí khảo sát, vui lòng thử lại sau!',
//         );
//         return;
//       }
//     }
//     if (surveyDetailData.desLocation == null) {
//       await showOkAlertDialog(
//           context: context,
//           message:
//               'Không tìm thấy vị trí kết thúc, vui lòng kiểm tra lại định vị và thử lại sau!');
//       Navigator.of(context).pop();
//       return;
//     }
//     await zoomOutCameraToShowAllPoint(
//       surveyDetailData.startLocation?.getLatLng(),
//       surveyDetailData.desLocation?.getLatLng(),
//     );

//     OkCancelResult result = await showOkCancelAlertDialog(
//       context: context,
//       title: 'Thông tin chuyến đi',
//       message:
//           '''Điểm đến: ${surveyDetailData.desAddress ?? ''}\n\nTổng quãng đường: ${(state.distanceInMeters / 1000).toPriceFormat()}km\n\nBạn có muốn bắt đầu chuyến đi?''',
//     );
//     if (result == OkCancelResult.ok) {
//       surveyDetailData.distance = state.distanceInMeters;
//       surveyDetailData.minutesId = state.assetDetail.id;
//       surveyDetailData.startLocation ??= LocalLatLng(
//         userLocation?.latitude.toString(),
//         userLocation?.longitude.toString(),
//       );

//       showLoading();
//       var fileUploadResult = await takeSnapshot(context);
//       if (fileUploadResult != null) {
//         surveyDetailData.imageId = fileUploadResult.link;
//         var startSurvey = await ref.read(minuteApiProvider).startMoving(
//               detailData: surveyDetailData,
//             );
//         hideLoading();
//         var isOK = await handleResponse(
//           startSurvey,
//           (data) {},
//         );
//         if (isOK == true) {
//           showOkAlertDialog(
//               context: context,
//               title: 'Thông báo',
//               message: 'Thêm vị trí bắt đầu thành công');
//           surveyDetailData.begin = true;
//         }
//       } else {
//         hideLoading();
//       }
//     }
//   }

//   ///Chụp ảnh bản đồ và upload lên server
//   Future<FileUploadModel?> takeSnapshot(
//     BuildContext context,
//   ) async {
//     var result = await controller?.takeSnapshot();
//     if (result == null) return null;
//     var uploadImage = await ref.read(fileServiceProvider).uploadFile(
//           result,
//           'routing_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
//           state.assetDetail.id,
//           path: FileService.movingMapPath,
//         );
//     if (uploadImage.status == Status.ERROR) {
//       await showOkAlertDialog(
//         context: context,
//         title: 'Thông báo',
//         message: 'Upload ảnh không thành công, vui lòng thử lại sau!',
//       );
//       return null;
//     }
//     return uploadImage.data;
//   }

//   // Future<dynamic> showImageViewerPage(
//   //   BuildContext context, {
//   //   List<String>? lsImage,
//   //   int index = 0,
//   // }) async {
//   //   Navigator.of(context).push(
//   //     MaterialPageRoute<Null>(
//   //       builder: (BuildContext context) {
//   //         return PhotoViewerWidget(
//   //           lsImage,
//   //           index: index,
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }

//   ///Lấy khoảng cách giữa 2 điểm
//   Future<double> getDistanceBetweenTwoPoint(
//     LatLng? start,
//     LatLng? destination,
//   ) async {
//     if (start == null || destination == null) return 0;
//     double totalDistance = 0.0;
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       kGoogleApiKey, // Google Maps API Key
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       travelMode: TravelMode.driving,
//     );

//     // Adding the coordinates to the list
//     if (result.points.isNotEmpty) {
//       for (var i = 0; i < result.points.length - 1; i++) {
//         totalDistance += Geolocator.distanceBetween(
//           result.points[i].latitude,
//           result.points[i].longitude,
//           result.points[i + 1].latitude,
//           result.points[i + 1].longitude,
//         );
//       }
//     }
//     return totalDistance;
//   }

//   ///Kết thúc khảo sát
//   Future endSurvey(BuildContext context) async {
//     if (state.surveyDetailData?.desLocation == null) {
//       await showOkAlertDialog(
//         context: context,
//         title: 'Thông báo',
//         message: 'Vị trí kết thúc không hợp lệ, vui lòng thử lại sau!',
//       );
//       return;
//     }
//     if (state.surveyDetailData?.startLocation == null) {
//       await showOkAlertDialog(
//         context: context,
//         title: 'Thông báo',
//         message: 'Vị trí bắt đầu không hợp lệ, vui lòng thử lại sau!',
//       );
//       return;
//     }
//     if (state.markers.length < 3) {
//       await showOkAlertDialog(
//         context: context,
//         title: 'Thông báo',
//         message: 'Không thể xác định địa điểm kết thúc, vui lòng thử lại sau!',
//       );
//       return;
//     }
//     if (userLocation == null) return;

//     //Phòng trường hợp lỗi cache vị trí trên một số thiết bị
//     if (state.surveyDetailData?.startLocation?.getLatLng() == userLocation) {
//       userLocation = state.surveyDetailData?.desLocation?.getLatLng();
//     }

//     //Lấy khoảng cách
//     var diffDistance = Geolocator.distanceBetween(
//       userLocation!.latitude,
//       userLocation!.longitude,
//       double.tryParse(state.surveyDetailData?.desLocation?.latitude ?? '0.0') ??
//           0.0,
//       double.tryParse(
//               state.surveyDetailData?.desLocation?.longitude ?? '0.0') ??
//           0.0,
//     );
//     var distanceFromStart = await getDistanceBetweenTwoPoint(
//       state.surveyDetailData?.startLocation?.getLatLng(),
//       userLocation,
//     );

//     //Lấy địa chỉ kết thúc khảo sát
//     geo.GeocodingResponse? location =
//         await googleGeocoding.geocoding.getReverse(
//             geo.LatLon(
//               userLocation?.latitude ?? 0.0,
//               userLocation?.longitude ?? 0.0,
//             ),
//             language: 'vi');

//     var endAddress = location?.results?.first.formattedAddress;
//     OkCancelResult result = await showOkCancelAlertDialog(
//       context: context,
//       title: 'Kết thúc chuyến đi',
//       message: '''Thông tin điểm dừng: $endAddress
          
// Quãng đường đã di chuyển: ${(distanceFromStart / 1000).toPriceFormat()}km
          
// Bạn có chắc muốn kết thúc chuyến đi không?
//           ''',
//     );

//     if (result == OkCancelResult.ok) {
//       showLoading();
//       var fileUploadResult = await takeSnapshot(context);
//       if (fileUploadResult != null) {
//         var endSurvey = await ref.read(minuteApiProvider).stopMoving(
//               surveyEndModel: SurveyEndModel(
//                 difference: diffDistance,
//                 endLocation: LocalLatLng('${userLocation?.latitude ?? 0.0}',
//                     '${userLocation?.longitude ?? 0.0}'),
//                 imageId: fileUploadResult.link,
//                 minutesId: state.surveyDetailData?.minutesId,
//                 endAddress: endAddress,
//                 endDistance: distanceFromStart,
//               ),
//             );
//         hideLoading();
//         var isOK = await handleResponse(
//           endSurvey,
//           (data) {},
//         );
//         if (isOK == true) {
//           // var detailBox = Hive.box<SurveyDetailData>('surveydetail');
//           // detailBox.delete(surveyDetailData.minutesId ?? '');
//           await showOkAlertDialog(
//             context: context,
//             title: 'Thông báo',
//             message: 'Kết thúc chuyến đi thành công',
//           );
//           Navigator.of(context).pop();
//         }
//       }
//     }
//   }

//   Future<bool> pinEndLocation(BuildContext context) async {
//     showLoading();
//     if (userLocation == null) {
//       userLocation = await getUserLocation();
//       if (userLocation == null) {
//         await showOkAlertDialog(
//           context: context,
//           title: 'Thông báo',
//           message: 'Không tìm thấy vị trí hiện tại, vui lòng thử lại sau!',
//         );
//         return false;
//       }
//     }
//     await setNewLocation(userLocation!);
//     setStopMarker(userLocation!);
//     await zoomOutCameraToShowAllPoint(
//       state.surveyDetailData?.desLocation?.getLatLng(),
//       userLocation,
//     );
//     await Future.delayed(const Duration(milliseconds: 500));
//     hideLoading();
//     return true;
//   }

//   ///Tìm đường di chuyển
//   Future findWay(BuildContext context) async {
//     await panelController.close();
//     bool drawLineResult = await drawPolylines(state.surveyDetailData);
//     if (drawLineResult) {
//       await zoomOutCameraToShowAllPoint(
//         state.surveyDetailData?.startLocation?.getLatLng(),
//         state.surveyDetailData?.desLocation?.getLatLng(),
//       );
//       await Future.delayed(const Duration(seconds: 300));
//     } else {
//       if (await showMessageAndGotoFindAddressPage(context)) {
//         findWay(context);
//       }
//     }
//   }

//   showMessageAndGotoFindAddressPage(BuildContext context) async {
//     var okCancelResult = await showOkCancelAlertDialog(
//       context: context,
//       title: 'Thông báo',
//       message:
//           'Không tìm thấy vị trí điểm đến, vui lòng xem lại địa chỉ khảo sát',
//     );
//     if (okCancelResult == OkCancelResult.ok) {
//       var surveyDetail = state.surveyDetailData;
//       var result = await showSearchLocationPage(context, surveyDetail);
//       updateDetail(surveyDetail);
//       if (result != null) return true;
//     }
//     return false;
//   }

//   void toggleExpand() {
//     state = state.copyWith.call(isExpand: !state.isExpand);
//   }

//   void updateDetail(SurveyDetailData? detailData) {
//     state = state.copyWith.call(surveyDetailData: detailData);
//   }

//   void updateFabHeight(double d) {
//     state = state.copyWith.call(fabHeight: d);
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     positionStream?.cancel();
//     super.dispose();
//   }

//   makePhoneCall() async {
//     try {
//       launch('tel://${state.assetDetail.contactNumber}');
//     } catch (e) {}
//   }
// }
