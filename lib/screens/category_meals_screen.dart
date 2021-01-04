import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:menuyo/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../widgets/meal_item.dart';
import 'cart_screen.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routName = '/category-meal';
  List<Item> _items;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String title = routeArgs['title'];
    this._items = routeArgs['items'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: this._items[index].id,
            title: this._items[index].name,
            description: this._items[index].description,
            imageUrl: this._items[index].imageUrl,
            price: this._items[index].price,
            available: this._items[index].available,
          );
        },
        itemCount: this._items.length,
      ),
    );
  }
}
