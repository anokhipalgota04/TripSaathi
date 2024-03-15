import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';




class Maping extends StatefulWidget {
  const Maping({Key? key}) : super(key: key);

  @override
  State<Maping> createState() => _MapingState();
}

class _MapingState extends State<Maping> {

  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  static const LatLng _kGooglePlex = LatLng(21.137870, 72.762922);
  //static const LatLng _kvip = LatLng(21.140423, 72.773243);
  LatLng?  _currentP = null;


  
  @override
  void initState() {
    super.initState();
    getLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _kGooglePlex == null ? const Center(child:Text("loading...") ,) 
      : GoogleMap(
        onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
        initialCameraPosition: CameraPosition(
          target: _kGooglePlex,
          zoom: 13,
          ),
          markers: {
            /*Marker(
              markerId: MarkerId("_currentlocation"),
            icon: BitmapDescriptor.defaultMarker, 
            position: _currentP!,
            ),
            Marker(
              markerId: MarkerId("_sourcelocation"),
            icon: BitmapDescriptor.defaultMarker, 
            position: _kGooglePlex),
            Marker(
              markerId: MarkerId("_destinationLocation"),
            icon: BitmapDescriptor.defaultMarker, 
            position: _kvip),*/
            },
            
          ),

    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 16,
    );
  await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition),
  );
  }
  Future<void> getLocationUpdate() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService(); 
    }else{
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await _locationController.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentlocation) {
      if (currentlocation.latitude != null && currentlocation.longitude != null){
        setState(() {
          _currentP = LatLng(currentlocation.latitude!, currentlocation.longitude!);
          _cameraToPosition(_currentP!);
        });
        
      }
    });
  }
}