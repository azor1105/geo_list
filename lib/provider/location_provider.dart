import 'package:flutter/material.dart';
import 'package:geo_list/data/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider({required LocationRepository locationRepository})
      : _locationRepository = locationRepository {
    getCurrentLocation();
  }

  final LocationRepository _locationRepository;
  Position? currentPositionOfUser;
  bool isLoading = true;
  String detailAddress = "";

  void getCurrentLocation() async {
    currentPositionOfUser = await _locationRepository.determinePosition();
    isLoading = false;
    notifyListeners();
  }

  void getAddressFromYandex() async {
    isLoading = true;
    notifyListeners();
    detailAddress = await _locationRepository.getLocationFromYandexMap(
      lat: currentPositionOfUser!.latitude,
      long: currentPositionOfUser!.longitude,
    );
    isLoading = false;
    notifyListeners();
  }

  void getAddressFromGeoLatLng() async {
    isLoading = true;
    notifyListeners();
    detailAddress = await _locationRepository.getLocationFromLatLng(
        lat: currentPositionOfUser!.latitude,
        long: currentPositionOfUser!.longitude);
    isLoading = false;
    notifyListeners();
  }

  void clearDetailAddress() {
    detailAddress = "";
  }

  Future<LatLng> getPositionFromGeoPlaceName({required String placeName}) async =>
      _locationRepository.getLocationFromPlaceName(placeName: placeName);
}
