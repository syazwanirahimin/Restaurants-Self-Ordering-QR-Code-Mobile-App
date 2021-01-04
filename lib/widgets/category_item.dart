import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../screens/category_meals_screen.dart';
import '../models/item.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String name;
  final List<Item> items;

  CategoryItem({this.id, this.name, this.items});

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealsScreen.routName,
        arguments: {'title': this.name, 'items': this.items});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          name,
          style: Theme.of(context).textTheme.headline5,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.7),
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
