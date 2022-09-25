import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class MyListsPresenter {
  final GetListsUsecase getUsecase;
  final CreateListUsecase createUsecase;
  final DeleteListUsecase deleteUsecase;
  final ShareListUsecase shareUsecase;

  MyListsPresenter({
    required this.getUsecase,
    required this.createUsecase,
    required this.deleteUsecase,
    required this.shareUsecase,
  });

  // Armazenar e fornecer todas as listas
  Stream<List<ShoppingListEntity>?> get listsStream => _lists.stream;
  final StreamController<List<ShoppingListEntity>?> _lists = StreamController();

  // Cuidar do comportamento do input do nome da lista
  TextEditingController createListName = TextEditingController(text: "");
  void onCleanText() => createListName.text = "";

  Future<void> getAllLists() async {
    try {
      var data = await getUsecase.getAll();
      _lists.add(data);
    } catch (e) {
      _lists.addError(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await deleteUsecase.delete(id);
      await getAllLists();
    } catch (e) {
      log("Não foi possível deletar a lista $id");
    }
  }

  Future<void> clone(ShoppingListEntity entity) async {
    try {
      ShoppingListEntity clonedList = ShoppingListEntity(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        id: generateMd5(DateTime.now().toString()),
        name: entity.name,
        description: entity.description,
        products: entity.products,
        tags: entity.tags,
      );

      await createUsecase.create(clonedList);
      await getAllLists();
    } catch (e) {
      log("Não foi possível clonar a lista ${entity.id}");
    }
  }

  Future<void> share(ShoppingListEntity entity) async {
    try {
      await shareUsecase.share(entity);
    } catch (e) {
      log("Erro ao compartilhar lista");
    }
  }

  Future<ShoppingListEntity> create() async {
    try {
      ShoppingListEntity newList = ShoppingListEntity(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        id: generateMd5(createListName.text),
        name: createListName.text,
        description: "",
        products: [],
        tags: [],
      );

      await Future.delayed(const Duration(seconds: 2), () async {
        await createUsecase.create(newList);
        await getAllLists();
      });

      return newList;
    } catch (e) {
      throw Exception("Não foi possível criar a lista");
    } finally {
      onCleanText();
    }
  }
}
