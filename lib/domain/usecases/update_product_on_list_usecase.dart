import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';

abstract class UpdateProductOnListUsecase {
  Future<ShoppingListEntity> updateProduct(
    String idList,
    ProductEntity product,
  );
}
