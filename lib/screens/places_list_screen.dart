import 'package:flutter/material.dart';
import 'package:m13_native_device/providers/great_places.dart';
import 'package:m13_native_device/screens/place_detail_screen.dart';

import 'package:provider/provider.dart';

import 'package:m13_native_device/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<GreatPlaces>(
                child: const Center(
                  child: Text("Got no places yet, start adding some!"),
                ),
                builder: (context, greatPlaces, ch) => greatPlaces
                    .items.isEmpty
                    ? ch!
                    : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      FileImage(greatPlaces.items[index].image!),
                    ),
                    title: Text(greatPlaces.items[index].title!),
                    subtitle: Text(greatPlaces.items[index].location!.address!),
                    onTap: () {
                      Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[index].id!);
                    },
                  ),
                ),
              );
            }
          }),
    );
  }
}
