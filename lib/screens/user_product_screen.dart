import 'package:flutter/material.dart';
import 'package:shop/widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: AppDrawers(),
      body: Container(
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (ctx, i) {
            return UserProductItem(
              imgUrl: productData.items[i].imageUrl,
              productId: productData.items[i].id,
              title: productData.items[i].title,
            );
          },
        ),
      ),
    );
  }
}
