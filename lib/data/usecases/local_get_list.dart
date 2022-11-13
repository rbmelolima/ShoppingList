import 'dart:convert';
import 'dart:developer';

import 'package:shoppinglist/data/cache/cache_storage.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';

class LocalGetLists implements GetListsUsecase {
  final CacheStorage cacheStorage;

  LocalGetLists(this.cacheStorage);

  @override
  Future<List<ShoppingListEntity>?> getAll() async {
    try {
      var listOfKeys = await cacheStorage.fetch("allKeys");
      if (listOfKeys == null) return null;

      List<dynamic> allKeys = jsonDecode(listOfKeys);
      List<ShoppingListEntity> list = [];

      for (var key in allKeys) {
        String? jsonList = await cacheStorage.fetch(key.toString());
        if (jsonList != null) {
          list.add(ShoppingListEntity.fromJson(jsonList));
        } else {
          log("Não foi possível encontrar a lista cujo ID é $key");
        }
      }
      return list;
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
        "Não foi possível listar a lista cujo id é $shoppingListId",
      );
    }
  }
}
