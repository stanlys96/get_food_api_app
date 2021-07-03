import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  String name;
  String pictureId;
  Menu({required this.name, required this.pictureId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
        width: 150.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/$pictureId',
              width: 120.0,
              height: 90.0,
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'IDR 15.000,00',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
