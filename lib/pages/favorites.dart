import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/restaurant_card.dart';
import '../data/model/restaurant.dart';

class FavoritesPage extends StatefulWidget {
  static const routeName = 'favorites_page';
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 240, 225, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 240, 225, 1),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('favorites')
                      .orderBy('dateCreated')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var restaurants = snapshot.data?.docs;
                    return Container(
                      height: 550,
                      child: ListView.builder(
                          itemCount: restaurants?.length,
                          itemBuilder: (context, index) {
                            var restaurant =
                                Restaurant.fromJson(restaurants?[index]);
                            return Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                RestaurantCard(restaurant: restaurant),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // set up the buttons
                                        Widget cancelButton = ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                          ),
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = ElevatedButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            var favorites_query = _firestore
                                                .collection('favorites');
                                            favorites_query.get().then((value) {
                                              value.docs.forEach((element) {
                                                if (element['name'] ==
                                                    restaurant.name) {
                                                  element.reference.delete();
                                                }
                                              });
                                            });
                                            Navigator.pop(context);
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Delete"),
                                          content: Text(
                                              "Are you sure you want to delete this item?"),
                                          actions: [
                                            cancelButton,
                                            continueButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
