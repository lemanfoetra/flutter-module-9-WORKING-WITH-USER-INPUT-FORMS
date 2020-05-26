import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String productId;
  final String title;
  final String imgUrl;

  UserProductItem({this.productId, this.title, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          ),
          title: Text(title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
