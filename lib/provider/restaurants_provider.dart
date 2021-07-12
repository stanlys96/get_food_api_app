import 'package:dicoding_mengengah_1/data/api/api_service.dart';
import 'package:dicoding_mengengah_1/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  RestaurantsListResult? _restaurantsResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  RestaurantsListResult? get result => _restaurantsResult;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurants();
      if (restaurants.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }

  Future<dynamic> getRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurants();
      if (restaurants.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }

  Future<dynamic> fetchRestaurantsResult(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getRestaurantsResult(query);
      if (restaurants.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurant(id);
  }

  RestaurantDetailResult? _restaurantResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  RestaurantDetailResult? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantDetail(id);
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
