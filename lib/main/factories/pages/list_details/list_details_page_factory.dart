import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';
import 'package:shoppinglist/ui/pages/list_details/list_details.dart';

Widget makeListDetailsPage(ShoppingListEntity list) {
  var presenter = ListDetailsPresenter(
    createUsecase: makeLocalCreateList(),
    deleteUsecase: makeLocalDeleteList(),
    shareUsecase: makeExternalShareList(),
    addProductUsecase: makeLocalAddProduct(),
    deleteProductUsecase: makeLocalDeleteProduct(),
    updateProductUsecase: makeLocalUpdateProduct(),
  );
  return ListDetailsPage(
    presenter: presenter,
    list: list,
  );
}
