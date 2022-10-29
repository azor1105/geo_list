// AIzaSyC2XC1Ufij41IZXkkwQmh26PBG7uEw0plw
import 'package:flutter/material.dart';
import 'package:geo_list/provider/location_provider.dart';
import 'package:geo_list/views/map/widgets/map_func_buttons.dart';
import 'package:geo_list/views/map/widgets/search_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final GoogleMapController googleMapController;
  MapType mapType = MapType.normal;
  Set<Marker> markers = {};
  late CameraPosition cameraPositionOnMove;
  @override
  Widget build(BuildContext context) {
    var currentPositionOfUser =
        context.watch<LocationProvider>().currentPositionOfUser;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Visibility(
          visible: !(context.watch<LocationProvider>().isLoading),
          child: FloatingActionButton(
            heroTag: "currentPosition",
            onPressed: () {
              animateCameraToChoosedLatLng(
                  lat: currentPositionOfUser!.latitude,
                  long: currentPositionOfUser.longitude);
            },
            child: const Icon(Icons.location_searching),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Map Screen"),
      ),
      body: context.watch<LocationProvider>().isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  onCameraMove: (CameraPosition position) {
                    cameraPositionOnMove = position;
                  },
                  markers: markers,
                  mapType: mapType,
                  onMapCreated: (controller) =>
                      googleMapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentPositionOfUser!.latitude,
                      currentPositionOfUser.longitude,
                    ),
                    zoom: 12.0,
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                MapFuncButtons(
                  changeMapType: changeMapType,
                  addMarker: () {
                    addMarker(
                      lat: cameraPositionOnMove.target.latitude,
                      long: cameraPositionOnMove.target.longitude,
                    );
                  },
                ),
                SearchTextField(
                  onSubmitted: (placeName) =>
                      locateToEnteredPlace(enteredPlace: placeName),
                )
              ],
            ),
    );
  }

  void changeMapType() {
    setState(() {
      if (mapType == MapType.normal) {
        mapType = MapType.hybrid;
      } else {
        mapType = MapType.normal;
      }
    });
  }

  void animateCameraToChoosedLatLng(
      {required double lat, required double long}) {
    googleMapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          lat,
          long,
        ),
        12.0,
      ),
    );
  }

  void addMarker({required double lat, required double long}) {
    setState(() {
      markers.add(
        Marker(
          infoWindow: const InfoWindow(
            title: "Comming soon",
            snippet: "Picked place for travelling",
          ),
          markerId: MarkerId(
            UniqueKey().toString(),
          ),
          position: LatLng(lat, long),
        ),
      );
    });
  }

  void locateToEnteredPlace({required String enteredPlace}) async {
    if (enteredPlace != "") {
      var latLngOfSearchedPlace =
          await context.read<LocationProvider>().getPositionFromGeoPlaceName(
                placeName: enteredPlace,
              );
      animateCameraToChoosedLatLng(
          lat: latLngOfSearchedPlace.latitude,
          long: latLngOfSearchedPlace.longitude);
    }
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }
}
