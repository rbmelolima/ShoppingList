import '../entities/shopping_list_entity.dart';

abstract class ShareListUsecase {
  Future<void> shareList(ShoppingListEntity shoppingList);
}