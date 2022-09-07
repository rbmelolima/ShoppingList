import 'package:shoppinglist/data/cache/cache_storage.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';

class LocalGetLists implements GetListsUsecase {
  final CacheStorage cacheStorage;

  LocalGetLists(this.cacheStorage);

  @override
  Future<List<ShoppingListEntity>?> getAll() async {
    try {
      List<String>? keys = await _retrieveShoppingListsKeys();
      if (keys == null) {
        return null;
      } else {
        List<ShoppingListEntity> list = List.empty();

        for (var element in keys) {
          list.add(ShoppingListEntity.fromJson(element));
        }

        return list;
      }
    } catch (e) {
      throw Exception("Não foi possível listar todas as listas");
    }
  }

  @override
  Future<ShoppingListEntity?> getById(String shoppingListId) async {
    try {
      var data = await cacheStorage.fetch(shoppingListId);

      if (data != null) {
        return ShoppingListEntity.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(
          "Não foi possível listar a lista cujo id é $shoppingListId");
    }
  }

  Future<List<String>?> _retrieveShoppingListsKeys() async {
    var all = await cacheStorage.fetch("all_shopping_lists");
    return all;
  }
}
