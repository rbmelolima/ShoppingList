import 'dart:convert';

import 'package:shoppinglist/data/cache/cache.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';

class LocalUpdateList implements UpdateListUsecase {
  final CacheStorage cacheStorage;

  LocalUpdateList(this.cacheStorage);

  @override
  Future<ShoppingListEntity> update(
    ShoppingListEntity shoppingList,
  ) async {
    try {
      var list = await cacheStorage.fetch(shoppingList.id);

      if (list != null) {
        await cacheStorage.delete(shoppingList.id);
        await cacheStorage.save(key: shoppingList.id, value: shoppingList);
        return shoppingList;
      } else {
        throw Exception("Não foi possível encontrar a lista");
      }
    } catch (e) {
      throw Exception("Não foi possível atualizar a lista");
    }
  }
}
