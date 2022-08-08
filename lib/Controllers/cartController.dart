import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:ashwinkart/Controllers/productController.dart';
import 'package:ashwinkart/model/cartData.dart';

class cartController extends ChangeNotifier {
  List<cartData> cartdatamodel = [
    cartData(
        imageUrl:
            'https://www.apple.com/v/iphone-13/h/images/key-features/compare/compare_iphone_13__b8xtgepe079e_large.jpg',
        name: 'iphone',
        model: '13',
        price: '\$799'),
    cartData(
        imageUrl:
            'https://img.giznext.com/assets/model/6/12260/oneplus-mobiles-oneplus-10t-1626949099.jpg',
        name: 'OnePlus',
        model: '10T',
        price: '\$699'),
    cartData(
        imageUrl:
            'https://m.media-amazon.com/images/I/61tCBXqRJvL._AC_SL1500_.jpg',
        name: 'Redmi',
        model: '10T',
        price: '\$499')
  ];

  productController product = productController();
  UnmodifiableListView<cartData> get cartitem {
    return UnmodifiableListView(cartdatamodel);
  }

  void addproduct(
      {required String ImageUrl,
      required String Name,
      required String Model,
      required String Price}) {
    final cartdata =
        cartData(imageUrl: ImageUrl, name: Name, model: Model, price: Price);
    cartdatamodel.add(cartdata);
    notifyListeners();
  }
}
