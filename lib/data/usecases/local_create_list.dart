import 'dart:convert';

import 'package:shoppinglist/data/cache/cache.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/create_list_usecase.dart';

class LocalCreateList implements CreateListUsecase {
  final CacheStorage cacheStorage;

  LocalCreateList(this.cacheStorage);

  @override
  Future<void> create(ShoppingListEntity shoppingList) async {
    try {
      var allKeys = await cacheStorage.fetch("allKeys");
      if (allKeys == null) {
        cacheStorage.save(key: "allKeys", value: jsonEncode([shoppingList.id]));
      } else {
        List<dynamic> dic = jsonDecode(allKeys);
        dic.add(shoppingList.id);
        cacheStorage.save(key: "allKeys", value: jsonEncode(dic));
      }

      await cacheStorage.save(
        key: shoppingList.id,
        value: shoppingList.toJson(),
      );
    } catch (e) {
      throw Exception("Não foi possível criar uma lista de compras");
    }
  }
}
