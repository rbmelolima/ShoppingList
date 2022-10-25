import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/factories/pages/price_analysis/price_analysis.dart';

import '../factories/pages/pages.dart';

class AppNavigation {
  static Future<dynamic> navigateToUpdateProduct(BuildContext context, ProductEntity product, String idList) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makeUpdateProductPage(idList, product),
      ),
    );
  }

  static Future<dynamic> navigateToUpdateList(BuildContext context, ShoppingListEntity list) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makeUpdateListPage(list),
      ),
    );
  }

  static Future<dynamic> navigateToListDetails(BuildContext context, ShoppingListEntity list) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makeListDetailsPage(list),
      ),
    );
  }

  static Future<dynamic> navigateToPriceAnalysis(BuildContext context, ShoppingListEntity list) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => makePriceAnalysisPage(list),
      ),
    );
  }
}
