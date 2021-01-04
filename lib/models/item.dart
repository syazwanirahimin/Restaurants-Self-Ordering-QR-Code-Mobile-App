import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool available;
  final String imageUrl;

  Item({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.available,
    @required this.imageUrl
  });
}