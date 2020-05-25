import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chart_provider.dart';
import '../providers/orders_provider.dart';
import '../widgets/chart_item.dart' as ChartItemWidget;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final chartObject = Provider.of<ChartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),

                  // Menampilkan Angka total harga Product
                  Chip(
                    label: Text(
                      "\$ ${chartObject.totalPrice}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      // Menambahkan items Chart ke Orders
                      Provider.of<OrdersProvider>(context).addOrder(
                        chartObject.items.values.toList(),
                        chartObject.totalPrice,
                      );

                      // Menghapus Chart Item
                      chartObject.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Proses Transaksi',
                            style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_right)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chartObject.items.length,
              itemBuilder: (ctx, i) {
                String productId = chartObject.items.keys.toList()[i];
                String chartId = chartObject.items.values.toList()[i].id;
                double chartPrice = chartObject.items.values.toList()[i].price;
                double quantity = chartObject.items.values.toList()[i].quantity;
                String title = chartObject.items.values.toList()[i].title;

                return Dismissible(
                  key: ValueKey(chartId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.redAccent,
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    chartObject.removeItem(productId);
                  },
                  confirmDismiss: (direction) {

                    // Alert Dialog
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Anda Yakin?'),
                        content: Text('Anda yakin menghapus cart ini?'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text('Tidak'),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text('Ya'),
                          ),
                        ],
                      ),
                    );
                    
                  },
                  child: ChartItemWidget.ChartItem(
                    id: chartId,
                    price: chartPrice,
                    quantity: quantity,
                    title: title,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
