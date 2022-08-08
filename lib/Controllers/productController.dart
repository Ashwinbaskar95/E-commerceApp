import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:ashwinkart/model/productData.dart';
import 'package:flutter/services.dart' as rootBundle;

class productController extends GetxController {
  static productController instance = Get.find();
  RxList<productData> products = RxList<productData>([]);
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(readjsondata().asStream());
  }

  Future<List<productData>> readjsondata() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('Productinfo/productinfo.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => productData.fromJson(e)).toList();
  }
}
