import 'package:shoppinglist/data/cache/cache.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/create_list_usecase.dart';

class LocalCreateList implements CreateListUsecase {
  final CacheStorage cacheStorage;

  LocalCreateList(this.cacheStorage);

  @override
  Future<void> create(ShoppingListEntity shoppingList) async {
    try {
      await _handleCacheLists(shoppingList.id);
      await cacheStorage.save(
        key: shoppingList.id,
        value: shoppingList.toMap(),
      );
    } catch (e) {
      throw Exception("Não foi possível criar uma lista de compras");
    }
  }

  Future<void> _handleCacheLists(String shoppingListId) async {
    var all = await cacheStorage.fetch("all_shopping_lists");
    if (all == null) {
      await cacheStorage.save(
        key: "all_shopping_lists",
        value: [shoppingListId],
      );
    } else {
      all as List;
      all.add(shoppingListId);
      await cacheStorage.save(key: "all_shopping_lists", value: all);
    }
  }
}
