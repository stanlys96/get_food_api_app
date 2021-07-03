import 'package:flutter/material.dart';
import '../pages/restaurant_detail.dart';
import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';
import 'package:provider/provider.dart';
import '../provider/restaurants_provider.dart';

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;
  RestaurantCard({required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(
                apiService: ApiService(),
                id: restaurant.id,
              ),
              child: RestaurantDetail(),
            );
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      width: 150.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_restaurant,
                            size: 18.0,
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              restaurant.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18.0,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            restaurant.city,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: Colors.teal,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                restaurant.rating.toStringAsFixed(1),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: Colors.orange,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              thickness: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
