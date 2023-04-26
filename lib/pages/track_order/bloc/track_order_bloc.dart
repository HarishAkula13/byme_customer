import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';
import 'dart:typed_data';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../common/utilities/byme_colors.dart';


typedef BlocProvider<TrackOrderBloc> TrackOrderFactory();
class TrackOrderBloc extends BlocBase{
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<List<Marker>> _markers =BehaviorSubject.seeded([]);
  BehaviorSubject<Tuple3<List<LatLng> ,List<Marker> ,Map<PolylineId, Polyline>>> _data =BehaviorSubject();
  BehaviorSubject<int> _dialogType =BehaviorSubject.seeded(0);
  Stream<int> get dialogType => _dialogType;
  Sink<int> get addDialogType => _dialogType;
  Stream<List<Marker>> get markers=> _markers;
  Stream<Tuple3<List<LatLng> ,List<Marker> ,Map<PolylineId, Polyline>>> get data=> _data;
  Stream<bool> get isLoading=> _isLoading;
  final List<LatLng> _latLen = <LatLng>[LatLng(17.4523004,78.3630278),
    LatLng(17.4308834,78.4023499),];
  final List<Marker> _markersData = <Marker>[];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBl0Pm1-cZM3-IdYhEkmEQ2A4XxSJpIRdQ";
  Map<PolylineId, Polyline> polylines = {};
  TrackOrderBloc(this.userDataStore){
    loadData();
    setListeners();
  }
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }
  loadData() async{
    for(int i=0 ;i<_latLen.length; i++){
      final Uint8List markIcons = await getImages('assets/images/marker.png', 100);
      _markersData.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.fromBytes(markIcons),
            position: _latLen[i],
          )
      );
    }
    _markers.add(_markersData);
  }
  void setListeners() {

    getDirections();
  }
  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_latLen[0].latitude, _latLen[0].longitude),
      PointLatLng(_latLen[1].latitude, _latLen[1].longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
       // printLog("lat",LatLng(point.latitude, point.longitude));
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: ByMeColors.app_color,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    _data.add(Tuple3(_latLen,_markersData,polylines));

  }
}