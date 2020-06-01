import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusPrice = FocusNode();
  final _focusNodeDescription = FocusNode();
  final _imgUrlController = TextEditingController();

  String _title;
  String _description;
  double _price;
  String _imgUrl;

  bool isInputUrlImage = false;
  Product _productData ;

  // untuk validate dan simpan data dari form
  void _simpanForm() {
    _formKey.currentState.save();

    _productData = Product(
      id: null,
      title: _title,
      description: _description,
      price: _price,
      imageUrl: _imgUrl,
    );

    print(_productData.title);
    print(_productData.price);
    print(_productData.description);
    print(_productData.imageUrl);
  }

  // ketika melaod image
  Widget _onLoadImage(loadingProgress) {
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes
            : null,
      ),
    );
  }

  // dispose() dijalankan ketika state widget dihancurkan
  @override
  void dispose() {
    // focus node dihancurkan agar tidak terjadi kebocoran memmory
    _focusPrice.dispose();
    _focusNodeDescription.dispose();
    _imgUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _simpanForm(),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
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
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focusPrice);
                  },
                  onSaved: (value) {
                    _title = value;
                  },
                ),

                // untuk price (harga)
                TextFormField(
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType
                      .number, // Untuk meng set type Input keyboard
                  focusNode: _focusPrice,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focusNodeDescription);
                  },
                  onSaved: (value) {
                    _price = double.parse(value);
                  },
                ),

                // unutk deskripsi
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3, // berarti 3 baris
                  focusNode: _focusNodeDescription,
                  onSaved: (value) {
                    _description = value;
                  },
                ),

                // untuk gambar
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 15),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: !isInputUrlImage
                          ? Center(
                              child: Text('No Image'),
                            )
                          : Image.network(
                              _imgUrlController.text,
                              fit: BoxFit.cover,

                              // menampilkan loading ketika image dimuata
                              loadingBuilder: (ctx, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return _onLoadImage(loadingProgress);
                                }
                              },
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: 'Image Url'),
                        controller: _imgUrlController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (isi) {
                          setState(() {
                            if (_imgUrlController.text.isEmpty) {
                              isInputUrlImage = false;
                            } else {
                              isInputUrlImage = true;
                            }
                          });
                        },
                        onSaved: (value) {
                          _imgUrl = value;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
