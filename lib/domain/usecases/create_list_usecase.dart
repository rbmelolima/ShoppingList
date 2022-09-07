import '../entities/shopping_list_entity.dart';

abstract class CreateListUsecase {
  Future<void> create(ShoppingListEntity shoppingList);
}