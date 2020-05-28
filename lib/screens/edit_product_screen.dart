import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _focusPrice = FocusNode();
  final _focusNodeDescription = FocusNode();


  // dispose() dijalankan ketika state widget dihancurkan
  @override
  void dispose() {
    
    // focus node dihancurkan agar tidak terjadi kebocoran memmory
    _focusPrice.dispose();
    _focusNodeDescription.dispose();

    super.dispose();
  }


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

              // untuk title
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,

                // Ketika tombol enter ditekan
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_focusPrice);
                },
              ),

              // untuk price (harga)
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,  // Untuk meng set type Input keyboard
                focusNode: _focusPrice,
                 onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_focusNodeDescription);
                },
              ),

              // unutk deskripsi
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                maxLines: 3,       // berarti 3 baris
                focusNode: _focusNodeDescription,
              ),
            ],
          ),
        )
        ),
      ),
    );
  }
}
