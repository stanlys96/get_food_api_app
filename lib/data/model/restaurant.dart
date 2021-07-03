import 'dart:convert';

class RestaurantsListResult {
  RestaurantsListResult({
    required this.error,
    this.founded,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String? message;
  int? founded;
  int? count;
  List<Restaurant>? restaurants;

  factory RestaurantsListResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsListResult(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        founded: json['founded'],
        restaurants: List<Restaurant>.from(
          (json['restaurants'] as List).map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'],
      );
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  Map<String, dynamic> parsed = jsonDecode(json);
  return parsed['restaurants']
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();
}
