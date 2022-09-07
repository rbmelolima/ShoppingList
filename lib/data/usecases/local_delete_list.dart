import 'package:shoppinglist/data/cache/cache_storage.dart';
import 'package:shoppinglist/domain/usecases/delete_list_usecase.dart';

class LocalDeleteList implements DeleteListUsecase {
  final CacheStorage cacheStorage;

  LocalDeleteList(this.cacheStorage);

  @override
  Future<void> delete(String shoppingListId) async {
    try {
      _handleCacheLists(shoppingListId);
      await cacheStorage.delete(shoppingListId);
    } catch (e) {
      throw Exception(
          "Não foi possível deletar a lista cujo ID é $shoppingListId");
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await cacheStorage.deleteAll();
    } catch (e) {
      throw Exception("Não foi possível deletar todas as listas");
    }
  }

  Future<void> _handleCacheLists(String shoppingListId) async {
    var all = await cacheStorage.fetch("all_shopping_lists");
    if (all != null) {
      all as List;
      all.remove(shoppingListId);
      await cacheStorage.save(key: "all_shopping_lists", value: all);
    }
  }
}
