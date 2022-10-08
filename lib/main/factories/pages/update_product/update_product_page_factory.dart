import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/ui/pages/update_product/update_product.dart';

Widget makeUpdateProductPage(ProductEntity product) {
  UpdateProductPresenter presenter = UpdateProductPresenter();

  return UpdateProductPage(
    presenter: presenter,
    product: product,
  );
}
