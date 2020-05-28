import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _focusPrice = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,

                // Ketika tombol enter ditekan
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_focusPrice);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,  // Untuk meng set type Input keyboard
                focusNode: _focusPrice,
              ),
            ],
          ),
        )
        ),
      ),
    );
  }
}
