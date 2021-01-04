import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:menuyo/screens/cart_screen.dart';
import 'package:menuyo/screens/review_screen.dart';
import 'package:provider/provider.dart';

import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'widgets/main_drawer.dart';
import 'screens/scan_screen.dart';
import 'models/meal.dart';
import 'models/category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> meals = new List<Meal>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline5: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold))),
        routes: {
          '/': (ctx) => this.meals.isEmpty
              ? ScanScreen(this.meals)
              : CategoriesScreen(this.meals[0].categories as List<Category>),
          CategoryMealsScreen.routName: (ctx) => CategoryMealsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          MealDetailScreen.routName: (ctx) => MealDetailScreen(),
          MainDrawer.routName: (ctx) => MainDrawer(),
          ScanScreen.routName: (ctx) => ScanScreen(this.meals),
          ReviewScreen.routeName: (ctx) => ReviewScreen(),
          CategoriesScreen.routName: (ctx) => CategoriesScreen(
              this.meals.isNotEmpty
                  ? this.meals[0].categories as List<Category>
                  : null),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (ctx) => CategoriesScreen(this.meals.isNotEmpty
                  ? this.meals[0].categories as List<Category>
                  : null));
        },
      ),
    );
  }
}
