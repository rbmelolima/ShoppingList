import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';

import '../factories/pages/pages.dart';

class AppNavigation {
  static Future<dynamic> navigateToUpdateProduct(
      BuildContext context, ProductEntity product) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makeUpdateProductPage(
          product,
        ),
      ),
    );
  }

  static Future<dynamic> navigateToListDetails(
      BuildContext context, ShoppingListEntity list) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makeListDetailsPage(
          list,
        ),
      ),
    );
  }
}
