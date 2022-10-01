import '../entities/shopping_list_entity.dart';

abstract class UpdateListUsecase {
  Future<ShoppingListEntity> update(ShoppingListEntity shoppingList);
}
