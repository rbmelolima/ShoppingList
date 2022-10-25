import 'dart:developer';

import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';

class PriceAnalysisPresenter {
  final PriceAnalysisUsecase priceAnalysisUsecase;

  PriceAnalysisPresenter({
    required this.priceAnalysisUsecase,
  });

  Future<List<SupplierEntity>> analysis(ShoppingListEntity list) async {
    try {
      //TODO: remover timer
      return await Future.delayed(const Duration(seconds: 10), () async {
        return await priceAnalysisUsecase.analysis(list);
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
