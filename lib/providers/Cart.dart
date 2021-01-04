import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {...this._items};
  }

  int get itemCount {
    return this._items.length;
  }

  double get totalAmount {
    var total = 0.0;
    this._items.forEach((key, item) {
      total += item.price * item.quantity;
    });

    return total;
  }

  void addItem(String productId, double price, String name) {
    if (this._items.containsKey(productId)) {
      this._items.update(
            productId,
            (item) => CartItem(
              id: item.id,
              name: item.name,
              price: item.price,
              quantity: item.quantity + 1,
            ),
          );
    } else {
      this._items.putIfAbsent(
            productId,
            () => CartItem(
              id: DateTime.now().toString(),
              name: name,
              price: price,
              quantity: 1,
            ),
          );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    this._items.remove(productId);
    notifyListeners();
  }

  void clear() {
    this._items = {};
    notifyListeners();
  }
}
