import 'package:geo_list/data/services/open_api_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepository {
  LocationRepository({required OpenApiServices apiServices})
      : _apiServices = apiServices;

  final OpenApiServices _apiServices;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getLocationFromYandexMap(
          {required double lat, required double long}) async =>
      _apiServices.getAddressFromYandexMap(lat: lat, long: long);

  Future<String> getLocationFromLatLng(
      {required double lat, required double long}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    var result =
        "${placemarks[0].country ?? ''} ${placemarks[0].name ?? ''} ${placemarks[0].street ?? ''}";
    return result;
  }

  Future<LatLng> getLocationFromPlaceName({required String placeName}) async {
    List<Location> location = await locationFromAddress(placeName);
    return LatLng(location[0].latitude, location[0].longitude);
  }
}
