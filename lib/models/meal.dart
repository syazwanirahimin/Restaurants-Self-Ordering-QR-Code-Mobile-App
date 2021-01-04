import 'package:flutter/foundation.dart';
import 'category.dart' as category;

class Meal {
  final String id;
  final List<category.Category> categories;
  final String name;
  final String description;
  final String address;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.name,
    @required this.description,
    @required this.address,
  });
}