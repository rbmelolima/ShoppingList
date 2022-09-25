import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class ListDetailsPresenter {
  final CreateListUsecase createUsecase;
  final DeleteListUsecase deleteUsecase;
  final ShareListUsecase shareUsecase;

  ListDetailsPresenter({
    required this.createUsecase,
    required this.deleteUsecase,
    required this.shareUsecase,
  });

  // Cuidar do comportamento do input de criar produto
  TextEditingController createProduct = TextEditingController(text: "");
  void onCleanText() => createProduct.text = "";

  Future<void> delete(String id) async {
    try {
      await deleteUsecase.delete(id);
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
}
