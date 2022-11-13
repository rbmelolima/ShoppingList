import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';
import 'package:shoppinglist/ui/pages/price_analysis/price_analysis.dart';

Widget makePriceAnalysisPage(ShoppingListEntity list) {
  PriceAnalysisPresenter presenter = PriceAnalysisPresenter(
    priceAnalysisUsecase: makeWebCrawlerPriceAnalysis(),
    shareUsecase: makeExternalShareList(),
  );

  return PriceAnalysisPage(presenter: presenter, shoppingList: list);
}
