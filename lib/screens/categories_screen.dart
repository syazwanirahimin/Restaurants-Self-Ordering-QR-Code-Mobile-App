import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:menuyo/screens/cart_screen.dart';
import 'package:menuyo/screens/review_screen.dart';
import 'package:menuyo/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';
import '../widgets/main_drawer.dart';
import '../models/category.dart';
import '../models/item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routName = '/categories-screen';
  final List<Category> _categories;

  CategoriesScreen(this._categories);

  Widget _buildBody(list) {
    if (list != null && list.isNotEmpty) {
      return GridView(
        padding: EdgeInsets.all(25),
        children: list.map<Widget>((data) {
          return CategoryItem(
            id: data.id,
            name: data.name,
            items: data.items as List<Item>,
          );
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      );
    }
    return Center(
      child: Text('QR code is not scanned.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.feedback_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ReviewScreen.routeName);
            },
          ),
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
      drawer: MainDrawer(),
      body: this._buildBody(this._categories),
    );
  }
}
