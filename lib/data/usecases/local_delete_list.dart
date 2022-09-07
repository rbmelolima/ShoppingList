import 'dart:convert';

import 'package:shoppinglist/data/cache/cache_storage.dart';
import 'package:shoppinglist/domain/usecases/delete_list_usecase.dart';

class LocalDeleteList implements DeleteListUsecase {
  final CacheStorage cacheStorage;

  LocalDeleteList(this.cacheStorage);

  @override
  Future<void> delete(String shoppingListId) async {
    try {
      var allKeys = await cacheStorage.fetch("allKeys");
      if (allKeys != null) {
        List<dynamic> dic = jsonDecode(allKeys);
        dic.remove(shoppingListId);
        await cacheStorage.save(key: "allKeys", value: jsonEncode(dic));
      }

      await cacheStorage.delete(shoppingListId);
    } catch (e) {
      throw Exception(
        "Não foi possível deletar a lista cujo ID é $shoppingListId",
      );
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
}
