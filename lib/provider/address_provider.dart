import 'package:flutter/material.dart';
import 'package:geo_list/data/repositories/address_repository.dart';
import '../data/models/address/address_model.dart';

class AddressProvider extends ChangeNotifier {
  AddressProvider({required AddressRepository addressRepository})
      : _addressRepository = addressRepository {
    getAllAddresses();
  }

  final AddressRepository _addressRepository;

  List<AddressModel> adresses = [];

  void getAllAddresses() {
    adresses =
        _addressRepository.getAddresses().values.toList().cast<AddressModel>();
    notifyListeners();
  }

  void addAddress({
    required String addressName,
    required String addressType,
    required DateTime createdDate,
    required double lat,
    required double long,
  }) {
    final address = AddressModel()
      ..addressName = addressName
      ..addressType = addressType
      ..createdDate = createdDate
      ..latitude = lat
      ..longtitude = long;

    _addressRepository.addAddress(address: address);
    getAllAddresses();
  }

  void deleteAddress(AddressModel addressModel) {
    addressModel.delete();
    getAllAddresses();
  }

  void clearAdresses() async {
    await _addressRepository.clearAddressBox();
    getAllAddresses();
  }
}
