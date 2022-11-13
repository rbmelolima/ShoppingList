import '../entities/shopping_list_entity.dart';

abstract class GetListsUsecase {
  Future<List<ShoppingListEntity>?> getAll();
  Future<ShoppingListEntity?> getById(String shoppingListId);
}
