import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:square_in_app_payments/models.dart' as squareModels;
import 'package:square_in_app_payments/in_app_payments.dart';

import '../providers/Cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId('sandbox-sq0idb-HwSXvSaa-H7xP-dgSUSr1g');
  }

  Future<void> _onStartCardEntryFlow(BuildContext context) async {
    final cart = Provider.of<Cart>(context, listen: false);
    this._initSquarePayment();
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow);
    cart.clear();
  }

  void _onCancelCardEntryFlow() {

  }

  void _onCardEntryCardNonceRequestSuccess(squareModels.CardDetails result) async {
    try {
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete
      );
    } on Exception catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _onCardEntryComplete() {
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (cart.itemCount != 0) {
                        this._onStartCardEntryFlow(context);
                      }
                    },
                    child: Text(
                      'Order now',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id ?? "",
                cart.items.keys.toList()[i] ?? "",
                cart.items.values.toList()[i].name ?? "",
                cart.items.values.toList()[i].price ?? "",
                cart.items.values.toList()[i].quantity ?? "",
              ),
              itemCount: cart.items.length,
            ),
          )
        ],
      ),
    );
  }
}
