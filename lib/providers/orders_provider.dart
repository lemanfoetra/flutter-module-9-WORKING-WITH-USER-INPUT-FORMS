import 'package:flutter/foundation.dart';
import 'package:shop/providers/chart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime time;
  final List<ChartItem> chartItem;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.time,
      @required this.chartItem});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }

  void addOrder(List<ChartItem> chartItem, double total) {
    _order.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          chartItem: chartItem,
          time: DateTime.now()
        ));
    notifyListeners();
  }
}
