import 'dart:developer';

import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';
import 'package:shoppinglist/domain/usecases/share_supplier_usecase.dart';

class PriceAnalysisPresenter {
  final PriceAnalysisUsecase priceAnalysisUsecase;
  final ShareSupplierUsecase shareUsecase;

  PriceAnalysisPresenter({
    required this.priceAnalysisUsecase,
    required this.shareUsecase,
  });

  Future<List<SupplierEntity>> analysis(ShoppingListEntity list) async {
    try {
      //TODO: remover timer
      return await Future.delayed(const Duration(seconds: 3), () async {
        return await priceAnalysisUsecase.analysis(list);
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> share(SupplierEntity supplier) async {
    try {
      await shareUsecase.shareSupplier(supplier);
    } catch (e) {
      log(e.toString());
    }
  }
}
