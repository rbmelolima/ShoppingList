import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';

class UpdateListPresenter {
  bool isEditing = false;
  bool wasEdited = false;

  late TextEditingController listName;
  late TextEditingController listDescription;
  late TextEditingController listTags;
  late ShoppingListEntity actualList;

  final UpdateListUsecase updateListUsecase;
  final DeleteListUsecase deleteListUsecase;

  UpdateListPresenter(this.updateListUsecase, this.deleteListUsecase) {
    listName = TextEditingController();
    listDescription = TextEditingController();
  }

  void dispose() {
    listName.dispose();
    listDescription.dispose();
  }

  void fill(ShoppingListEntity list) {
    actualList = list;
    listName.text = list.name;
    listDescription.text = list.description ?? "";
  }

  Future<void> save() async {
    try {
      isEditing = false;
      wasEdited = true;

      ShoppingListEntity updatedList = ShoppingListEntity(
        id: actualList.id,
        createdAt: actualList.createdAt,
        updatedAt: DateTime.now().toString(),
        name: listName.text.trim(),
        description: listDescription.text.trim(),
        products: actualList.products,
      );

      await updateListUsecase.update(updatedList);
    } catch (e) {
      log("Não foi possível salvar a edição");
      rethrow;
    }
  }

  Future<bool> delete() async {
    try {
      isEditing = false;
      wasEdited = true;
      await deleteListUsecase.delete(actualList.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
