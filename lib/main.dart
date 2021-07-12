import 'package:dicoding_mengengah_1/provider/restaurants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import './pages/restaurants_page.dart';
import './pages/favorites.dart';
import './pages/restaurant_detail.dart';
import './data/api/api_service.dart';
import './utils/notification_helper.dart';
import './utils/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationHelper _notificationHelper = NotificationHelper();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  _notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  AndroidAlarmManager.initialize();
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
        },
        RestaurantDetail.routeName: (context) =>
            RestaurantDetail(id: ModalRoute.of(context)?.settings.arguments),
      },
    );
  }
}
