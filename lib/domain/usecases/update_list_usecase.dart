import '../entities/shopping_list_entity.dart';

abstract class UpdateListUsecase {
  Future<void> update(ShoppingListEntity shoppingList);
}