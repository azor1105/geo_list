import 'package:flutter/material.dart';
import 'package:geo_list/provider/address_provider.dart';
import 'package:geo_list/views/map/map_screen.dart';
import 'package:geo_list/views/save_address/save_address_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int countOfAddresses = context.watch<AddressProvider>().adresses.length;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "add button",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SaveAddressScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Saved Locations"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddressProvider>().clearAdresses();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MapScreen(),
                ),
              );
            },
            icon: const Icon(Icons.location_on),
          ),
        ],
      ),
      body: countOfAddresses == 0
          ? const Center(
              child: Text("No saved addresses"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                var address = context.read<AddressProvider>().adresses[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Card(
                    child: ListTile(
                      leading: Icon(address.addressType == 'home'
                          ? Icons.home
                          : address.addressType == 'work'
                              ? Icons.work
                              : Icons.gamepad),
                      title: Text(address.addressName),
                      subtitle:
                          Text(DateFormat.yMMMd().format(address.createdDate)),
                      onLongPress: () {
                        context.read<AddressProvider>().deleteAddress(address);
                      },
                    ),
                  ),
                );
              },
              itemCount: countOfAddresses,
            ),
    );
  }
}
