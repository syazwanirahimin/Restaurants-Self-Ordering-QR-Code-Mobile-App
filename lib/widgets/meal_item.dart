import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:menuyo/screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool available;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    @required this.available,
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routName, arguments: {
      'id': this.id,
      'name': this.title,
      'description': this.description,
      'imageUrl': this.imageUrl,
      'price': this.price,
      'available': this.available,
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return InkWell(
      onTap: () => this.selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  this.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(children: [
                    Icon(
                      Icons.attach_money,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('\$${this.price}'),
                  ]),
                  Row(children: [
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        cart.addItem(this.id, this.price, this.title);
                      },
                    ),
                    SizedBox(
                      width: 6,
                    ),
                  ]),
                ]),
          )
        ]),
      ),
    );
  }
}
