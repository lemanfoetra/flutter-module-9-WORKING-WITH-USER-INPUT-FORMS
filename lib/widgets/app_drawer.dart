import 'package:flutter/material.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/order_screen.dart';

class AppDrawers extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          Divider(),

          //
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),


          //
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (){
              Navigator.of(context).pushNamed(OrdersScreeen.routeName);
            },
          )

        ],
      ),
    );
  }
}
