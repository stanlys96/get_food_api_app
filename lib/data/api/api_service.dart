import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsListResult> getRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + '/list'));
    if (response.statusCode == 200) {
      return RestaurantsListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantsListResult> getRestaurantsResult(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + '/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantsListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + '/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }
}
