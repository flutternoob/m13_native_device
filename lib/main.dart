import 'package:flutter/material.dart';
import 'package:m13_native_device/providers/great_places.dart';
import 'package:m13_native_device/screens/add_place_screen.dart';
import 'package:m13_native_device/screens/place_detail_screen.dart';
import 'package:m13_native_device/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen()
        },
      ),
    );
  }
}