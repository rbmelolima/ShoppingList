abstract class DeleteListUsecase {
  Future<void> delete(String shoppingListId);
  Future<void> deleteAll();
}