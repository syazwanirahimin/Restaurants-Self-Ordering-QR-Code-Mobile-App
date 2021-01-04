import 'package:flutter/material.dart';
import 'package:menuyo/providers/Cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;

  CartItem(this.id, this.productId, this.name, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(this.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(this.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(padding: EdgeInsets.all(5), child: FittedBox(child: Text('\$${this.price}'))),
            ),
            title: Text(this.name),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('${this.quantity} x'),
          ),
        ),
      ),
    );
  }
}
