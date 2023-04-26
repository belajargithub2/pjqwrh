import 'package:flutter/material.dart';

class MultiAssetModel {
  String? assetCode;
  int? qty;
  int? price;
  String? description;
  String? categoryId;
  String? categoryName;
  bool? isSearchProduct;
  TextEditingController? name;
  TextEditingController? priceController;

  MultiAssetModel({
    this.assetCode,
    this.qty,
    this.price,
    this.description,
    this.categoryId,
    this.categoryName,
    this.isSearchProduct = false,
    this.name,
    this.priceController,
  });

  Map<String, dynamic> toJson() => {
    "code": assetCode,
    "description": description,
    "category_id": categoryId,
    "category_name": categoryName,
    "otr": price,
    "qty": qty,
  };

}
