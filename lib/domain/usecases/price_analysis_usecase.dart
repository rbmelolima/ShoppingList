import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';

abstract class PriceAnalysisUsecase {
  Future<List<SupplierEntity>> analysis(ShoppingListEntity shoppingList);
}



