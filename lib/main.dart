import 'package:flutter/material.dart';
import 'package:geo_list/constants/hive_constants.dart';
import 'package:geo_list/data/repositories/address_repository.dart';
import 'package:geo_list/data/repositories/location_repository.dart';
import 'package:geo_list/data/services/open_api_services.dart';
import 'package:geo_list/provider/address_provider.dart';
import 'package:geo_list/provider/location_provider.dart';
import 'package:geo_list/views/home/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'data/models/address/address_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox<AddressModel>(HiveConstants.instance.addressBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AddressProvider(
            addressRepository: AddressRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(
            locationRepository: LocationRepository(
              apiServices: OpenApiServices(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
