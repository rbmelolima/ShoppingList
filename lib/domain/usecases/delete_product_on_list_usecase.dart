import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';

abstract class DeleteProductOnListUsecase {
  Future<ShoppingListEntity> deleteProduct(
    String idList,
    String idProduct,
  );
}
