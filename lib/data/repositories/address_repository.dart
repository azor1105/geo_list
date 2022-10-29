import 'package:geo_list/constants/hive_constants.dart';
import 'package:hive/hive.dart';

import '../models/address/address_model.dart';

class AddressRepository {
  Box<AddressModel> getAddresses() =>
      Hive.box<AddressModel>(HiveConstants.instance.addressBox);

  Future addAddress({required AddressModel address}) async {
    final addressBox = getAddresses();

    addressBox.add(address);
  }

  Future clearAddressBox() async {
    final addressBox = getAddresses();
    await addressBox.clear();
  }
}



// 3A:5B:2E:4C:05:D2:61:3F:1F:5D:71:7A:86:0A:90:D0:9E:A1:2A:42