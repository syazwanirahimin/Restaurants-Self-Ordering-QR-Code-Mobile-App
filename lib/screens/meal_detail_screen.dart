import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:menuyo/widgets/badge.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final meal =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${meal['price']}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              meal['description'],
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          FlatButton(
            onPressed: () {
              cart.addItem(meal['id'], meal['price'], meal['title']);
            },
            child: Text(
              'Add to cart',
            ),
            textColor: Theme.of(context).primaryColor,
          )
        ]),
      ),
    );
  }
}
