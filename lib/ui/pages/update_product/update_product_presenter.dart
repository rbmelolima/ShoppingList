import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';

class UpdateProductPresenter {
  UpdateProductPresenter() {
    productName = TextEditingController();
    productQuantifierValue = TextEditingController();
    productBrand = TextEditingController();
    productDetails = TextEditingController();
  }

  void dispose() {
    productName.dispose();
    productQuantifierValue.dispose();
    productBrand.dispose();
    productDetails.dispose();
  }

  late TextEditingController productName;
  late TextEditingController productQuantifierValue;
  late TextEditingController productBrand;
  late TextEditingController productDetails;
  String? productQuantifierType;
  late String productId;

  void fill(ProductEntity initialValue) {
    productName.text = initialValue.name;
    productBrand.text = initialValue.brand ?? "";
    productQuantifierValue.text = initialValue.measure ?? "";
    productQuantifierType = initialValue.unitOfMeasurement;
    productDetails.text = initialValue.description ?? "";
    productId = initialValue.id;
  }

  Future<void> save() async {
    ProductEntity product = ProductEntity(
      id: productId,
      name: productName.text,
      brand: productBrand.text,
      measure: productQuantifierValue.text,
      unitOfMeasurement: productQuantifierType,
      description: productDetails.text,
    );

    log("salvo com sucesso!");
  }
}
