import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';
import '../model/restaurant_detail.dart';

int timeout = 5;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsListResult> getRestaurants() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + '/list'))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        return RestaurantsListResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants list');
      }
    } on TimeoutException catch (e) {
      throw Exception('Timeout error. Please check your internet connection');
    } on SocketException catch (e) {
      throw Exception(
          'Socket Error: Please check that you have internet permission to your app.');
    } on Error catch (e) {
      throw Exception('General Error: $e');
    }
  }

  Future<RestaurantsListResult> getRestaurantsResult(String query) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + '/search?q=$query'))
          .timeout(Duration(seconds: timeout));
      ;
      if (response.statusCode == 200) {
        return RestaurantsListResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants list');
      }
    } on TimeoutException catch (e) {
      throw Exception('Timeout error. Check your internet connection');
    } on SocketException catch (e) {
      throw Exception(
          'Socket Error: Please check that you have internet permission to your app.');
    } on Error catch (e) {
      throw Exception('General Error: $e');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl + '/detail/$id'))
          .timeout(Duration(seconds: timeout));
      ;
      if (response.statusCode == 200) {
        return RestaurantDetailResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants list');
      }
    } on TimeoutException catch (e) {
      throw Exception('Timeout error. Check your internet connection');
    } on SocketException catch (e) {
      throw Exception(
          'Socket Error: Please check that you have internet permission to your app.');
    } on Error catch (e) {
      throw Exception('General Error: $e');
    }
  }

  // Future<http.Response> addReview(String name, String title, String id) async {
  //   return await http.post(
  //       (Uri.parse('https://restaurant-api.dicoding.dev/review')),
  //       headers: <String, String>{
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         'X-Auth-Token': '12345'
  //       },
  //       body: {
  //         "id": id,
  //         "name": name,
  //         "title": title,
  //       });
  // }
}
