import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chart_provider.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imgUrl;

  // ProductItem({this.id, this.title, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final dataProduct = Provider.of<Product>(context, listen: false);
    final dataChart = Provider.of<ChartProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: dataProduct.id,
        );
      },
      child: Consumer<Product>(
        builder: (ctx, dataProduct, child) => ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.3,
                ),
              ),
              child: Image.network(
                dataProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            header: GridTileBar(
              leading: IconButton(
                icon: Icon(
                  dataProduct.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  dataProduct.setFavorite();
                },
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black26,
              leading: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.yellow,
                ),
                onPressed: () {
                  dataChart.addChart(
                    dataProduct.id,
                    dataProduct.price,
                    dataProduct.title,
                  );

                  // Menghide snakbar yang sebelumnya aktif
                  Scaffold.of(context).hideCurrentSnackBar();

                  // Menampilkan Snackbar ketika produk berhasil di tambahkan ke cart
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Produk ditambahkan!'),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        textColor: Colors.red,
                        label: 'UNDO',
                        onPressed: () {
                          dataChart.removeSingleItem(dataProduct.id);
                        },
                      ),
                    ),
                  );
                },
              ),
              title: Text(
                dataProduct.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
