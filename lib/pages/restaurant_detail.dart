import 'package:dicoding_mengengah_1/provider/restaurants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/menu.dart';
import '../components/secondary_heading.dart';

Widget okButton(context, color) => ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

// set up the AlertDialog
AlertDialog alert(context) => AlertDialog(
      title: Text("Success!"),
      content: Text("Successfully added to favorites!"),
      actions: [
        okButton(context, Colors.blue),
      ],
    );

AlertDialog error(context) => AlertDialog(
      title: Text("Error!"),
      content: Text("This restaurant is already added to favorites!"),
      actions: [
        okButton(context, Colors.red),
      ],
    );

class RestaurantDetail extends StatefulWidget {
  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  var _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 240, 225, 1),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.result?.restaurant;
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
                      title: Text(restaurant!.name),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: IconButton(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                              maxWidth: 40.0,
                              maxHeight: 40.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            child: Hero(
                              tag: restaurant!.pictureId,
                              child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}'),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    var found = false;
                                    var favorites_query =
                                        _firestore.collection('favorites');
                                    favorites_query.get().then((value) {
                                      value.docs.forEach((element) {
                                        if (element['name'] ==
                                            restaurant.name) {
                                          found = true;
                                        }
                                      });
                                      if (!found) {
                                        _firestore.collection('favorites').add({
                                          'id': restaurant.id,
                                          'name': restaurant.name,
                                          'pictureId': restaurant.pictureId,
                                          'description': restaurant.description,
                                          'city': restaurant.city,
                                          'rating': restaurant.rating,
                                          'dateCreated': Timestamp.now(),
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert(context);
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return error(context);
                                          },
                                        );
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 20.0,
                        ),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            SizedBox(height: 10.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  '${restaurant.city}, ${restaurant.address}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            SecondaryHeading(
                              text: 'DESCRIPTION',
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              restaurant.description,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SecondaryHeading(
                              text: 'FOOD',
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              height: 160.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.menus?.foods.length,
                                itemBuilder: (context, index) {
                                  return Menu(
                                    name: restaurant.menus!.foods[index].name,
                                    pictureId: restaurant.pictureId,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SecondaryHeading(
                              text: 'DRINK',
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              height: 160.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.menus?.drinks.length,
                                itemBuilder: (context, index) {
                                  return Menu(
                                    name: restaurant.menus!.drinks[index].name,
                                    pictureId: restaurant.pictureId,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SecondaryHeading(
                                  text: 'REVIEWS',
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 250.0,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: restaurant.customerReviews?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restaurant
                                              .customerReviews![index].name,
                                        ),
                                        Text(
                                          restaurant
                                              .customerReviews![index].review,
                                        ),
                                        Text(
                                          restaurant
                                              .customerReviews![index].date,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
