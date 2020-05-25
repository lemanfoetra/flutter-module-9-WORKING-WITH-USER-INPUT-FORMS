import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/order_item.dart';

class OrdersScreeen extends StatelessWidget {

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Order')),
      body: ListView.builder(
        itemCount: ordersData.order.length,
        itemBuilder: (ctx, i) => OrderItem(ordersData.order[i]),
      ),
    );
  }
}
