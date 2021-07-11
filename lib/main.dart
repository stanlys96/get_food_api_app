import 'package:dicoding_mengengah_1/provider/restaurants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './pages/restaurants_page.dart';
import './pages/favorites.dart';
import './data/api/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantsPage.routeName,
      routes: {
        RestaurantsPage.routeName: (context) {
          return ChangeNotifierProvider<RestaurantsProvider>(
            create: (_) => RestaurantsProvider(
              apiService: ApiService(),
            ),
            child: RestaurantsPage(),
          );
        },
        FavoritesPage.routeName: (context) {
          return FavoritesPage();
        }
      },
    );
  }
}
