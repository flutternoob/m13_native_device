import 'dart:convert';

import 'package:http/http.dart' as http;

const googleApiKey = "AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI";

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Alabel:C%7C40.718217,-73.998284&key=$googleApiKey&signature=YOUR_SIGNATURE";
  }

  static Future<String> getAddress(double lat, double lng) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng &location_type=ROOFTOP&result_type=street_address&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)["results"][0]["formatted_address"];
  }
}