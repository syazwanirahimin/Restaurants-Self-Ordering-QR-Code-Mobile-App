import 'package:flutter/foundation.dart';
import 'item.dart';

class Category {
  final String id;
  final String name;
  final List<Item> items;

  const Category({
    @required this.id,
    @required this.name,
    @required this.items
  });
}