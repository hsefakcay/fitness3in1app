// lib/util/edamam_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class EdamamAPI {
  final String appId;
  final String appKey;

  EdamamAPI({required this.appId, required this.appKey});

  Future<Map<String, dynamic>> searchFood(String query) async {
    final String baseUrl = "https://api.edamam.com/api/food-database/v2/parser";
    final String url = "$baseUrl?ingr=$query&app_id=$appId&app_key=$appKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load food data');
    }
  }
}
