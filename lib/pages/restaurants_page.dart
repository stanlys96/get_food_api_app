import 'package:dicoding_mengengah_1/provider/restaurants_provider.dart';
import 'package:dicoding_mengengah_1/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../components/restaurant_card.dart';
import '../utils/notification_helper.dart';
import '../utils/background_service.dart';
import '../pages/restaurant_detail.dart';
import '../pages/settings_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class RestaurantsPage extends StatefulWidget {
  static const routeName = 'restaurant_page';
  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
        context, RestaurantDetail.routeName);
    _notificationHelper.configureDidReceiveLocalNotificationSubject(
        context, RestaurantDetail.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 240, 225, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25.0,
            right: 25.0,
            bottom: 10.0,
            top: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'GetFood',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Icon(Icons.local_restaurant)
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.settings),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<SchedulingProvider>(
                                  create: (_) => SchedulingProvider(),
                                  child: SettingsPage(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 17.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.favorite),
                          onPressed: () async {
                            Navigator.pushNamed(context, 'favorites_page');
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (val) {
                            Provider.of<RestaurantsProvider>(context,
                                    listen: false)
                                .fetchRestaurantsResult(val);
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'Restaurant 1',
                          ),
                        ),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Recommended restaurants for you!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Consumer<RestaurantsProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Loading restaurants for you.\nPlease wait...',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result?.restaurants?.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.result?.restaurants?[index];
                          return RestaurantCard(
                            restaurant: restaurant!,
                          );
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(
                          child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ));
                    } else if (state.state == ResultState.Error) {
                      return Center(
                          child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
