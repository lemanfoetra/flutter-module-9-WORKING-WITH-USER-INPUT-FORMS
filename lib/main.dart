import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/order_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/product_provider.dart';
import './providers/chart_provider.dart';
import './providers/orders_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ChartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductOverviewScreeen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreeen.routeName: (ctx) => OrdersScreeen(),
        },
        onUnknownRoute: (setting) {
          return MaterialPageRoute(
            builder: (ctx) => ProductOverviewScreeen(),
          );
        },
      ),
    );
  }
}
