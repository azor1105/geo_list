import 'package:flutter/material.dart';
import 'package:geo_list/provider/address_provider.dart';
import 'package:geo_list/provider/location_provider.dart';
import 'package:geo_list/views/save_address/widgets/location_type_button.dart';
import 'package:provider/provider.dart';

class SaveAddressScreen extends StatefulWidget {
  const SaveAddressScreen({super.key});

  @override
  State<SaveAddressScreen> createState() => _SaveAddressScreenState();
}

class _SaveAddressScreenState extends State<SaveAddressScreen> {
  String selectedType = "home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save location"),
      ),
      body: context.watch<LocationProvider>().isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<LocationProvider>(
              builder: (context, instanceOfLocation, child) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Latitude: ${instanceOfLocation.currentPositionOfUser!.latitude}"),
                      const SizedBox(height: 20),
                      Text(
                          "Longtitude: ${instanceOfLocation.currentPositionOfUser!.longitude}"),
                      const SizedBox(height: 20),
                      LocationTypeButton(
                        onPressed: () {
                          setState(() {
                            selectedType = "home";
                          });
                        },
                        isSelected: selectedType == 'home',
                        title: "Home",
                        iconData: Icons.home,
                      ),
                      LocationTypeButton(
                        onPressed: () {
                          setState(() {
                            selectedType = "work";
                          });
                        },
                        isSelected: selectedType == 'work',
                        title: "Work",
                        iconData: Icons.work,
                      ),
                      LocationTypeButton(
                        onPressed: () {
                          setState(() {
                            selectedType = "game";
                          });
                        },
                        isSelected: selectedType == 'game',
                        title: "Game",
                        iconData: Icons.gamepad,
                      ),
                      const SizedBox(height: 15),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            instanceOfLocation.detailAddress,
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          instanceOfLocation.getAddressFromYandex();
                        },
                        child: const Text("Get from yandex"),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          instanceOfLocation.getAddressFromGeoLatLng();
                        },
                        child: const Text("Get from geocoding"),
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          if (context.read<LocationProvider>().detailAddress !=
                              "") {
                            context.read<AddressProvider>().addAddress(
                                  addressName: instanceOfLocation.detailAddress,
                                  addressType: selectedType,
                                  createdDate: DateTime.now(),
                                  lat: instanceOfLocation
                                      .currentPositionOfUser!.latitude,
                                  long: instanceOfLocation
                                      .currentPositionOfUser!.latitude,
                                );
                            context
                                .read<LocationProvider>()
                                .clearDetailAddress();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
