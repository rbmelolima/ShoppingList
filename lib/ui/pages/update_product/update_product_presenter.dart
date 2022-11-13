import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/domain/usecases/delete_product_on_list_usecase.dart';
import 'package:shoppinglist/domain/usecases/update_product_on_list_usecase.dart';

class UpdateProductPresenter {
  bool isEditing = false;
  bool wasEdited = false;

  late TextEditingController productName;
  late TextEditingController productQuantifierValue;
  late TextEditingController productBrand;
  late TextEditingController productDetails;
  late String? productQuantifierType;
  late String productId;

  final UpdateProductOnListUsecase updateUsecase;
  final DeleteProductOnListUsecase deleteUsecase;

  UpdateProductPresenter(this.updateUsecase, this.deleteUsecase) {
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

  void fill(ProductEntity initialValue) {
    productName.text = initialValue.name;
    productBrand.text = initialValue.brand ?? "";
    productQuantifierValue.text = initialValue.measure ?? "";
    productQuantifierType = initialValue.unitOfMeasurement;
    productDetails.text = initialValue.description ?? "";
    productId = initialValue.id;
  }

  Future<void> save(String listId) async {
    try {
      isEditing = false;
      wasEdited = true;
      ProductEntity product = ProductEntity(
        id: productId,
        name: productName.text.trim(),
        brand: productBrand.text.trim(),
        measure: productQuantifierValue.text.trim(),
        unitOfMeasurement: productQuantifierType,
        description: productDetails.text.trim(),
      );

      await updateUsecase.updateProduct(listId, product);
    } catch (e) {
      log("Não foi possível salvar a edição");
      rethrow;
    }
  }

  Future<bool> delete(String idList) async {
    try {
      isEditing = false;
      wasEdited = true;
      await deleteUsecase.deleteProduct(idList, productId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
