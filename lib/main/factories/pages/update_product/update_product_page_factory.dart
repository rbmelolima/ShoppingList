import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';
import 'package:shoppinglist/ui/pages/update_product/update_product.dart';

Widget makeUpdateProductPage(String idList, ProductEntity product) {
  UpdateProductPresenter presenter = UpdateProductPresenter(
    makeLocalUpdateProduct(),
    makeLocalDeleteProduct(),
  );

  return UpdateProductPage(
    presenter: presenter,
    product: product,
    idList: idList,
  );
}
