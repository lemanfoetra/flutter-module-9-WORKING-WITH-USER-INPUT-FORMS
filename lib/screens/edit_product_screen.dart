import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // buat form key agar form diketahui flutter
  final _formKey = GlobalKey<FormState>();
  final _focusPrice = FocusNode();
  final _focusNodeDescription = FocusNode();
  final _imgUrlController = TextEditingController();

  String _title;
  String _description;
  double _price;
  String _imgUrl;

  bool isInputUrlImage = false;
  Product _productData;

  void _simpanForm(BuildContext scaffoldContext) {
    // Deklarasikan ini agar validate berjalan
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      // untuk menyimpan form
      _formKey.currentState.save();

      _productData = Product(
        id: null,
        title: _title,
        description: _description,
        price: _price,
        imageUrl: _imgUrl,
      );

      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_productData);


      Scaffold.of(scaffoldContext).showSnackBar(
        SnackBar(
          content: Text('Product Added'),
          duration: Duration(
            seconds: 3
          ),
        ),
      );
      //Navigator.of(context).pop();
    }
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
          Builder(
            builder: (BuildContext scaffoldContext) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _simpanForm(scaffoldContext),
            ),
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
                  // bisa gunakan onSaved() untuk menyimpan datanya ketika di submit
                  onSaved: (value) {
                    _title = value;
                  },

                  // gunakan validator untuk validasi. return null = true, return string = false
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title Perlu Disi";
                    }
                    return null;
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
                  // bisa gunakan onSaved() untuk menyimpan datanya ketika di submit
                  onSaved: (value) {
                    if (value.isEmpty) {
                      _price = 0;
                    } else {
                      _price = double.parse(value);
                    }
                  },

                  validator: (value) {
                    if (value.isEmpty) {
                      return "Price perlu diisi.";
                    }
                    return null;
                  },
                ),

                // unutk deskripsi
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3, // berarti 3 baris
                  focusNode: _focusNodeDescription,
                  // bisa gunakan onSaved() untuk menyimpan datanya ketika di submit
                  onSaved: (value) {
                    _description = value;
                  },

                  validator: (value) {
                    if (value.isEmpty) {
                      return "Description Perlu diisi";
                    }
                    return null;
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

                        // bisa gunakan onSaved() untuk menyimpan datanya ketika di submit
                        onSaved: (value) {
                          _imgUrl = value;
                        },

                        validator: (value) {
                          if (value.isEmpty) {
                            return "Image perlu diisi.";
                          }
                          return null;
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
