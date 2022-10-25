import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class ListDetailsPresenter {
  final CreateListUsecase createListUsecase;
  final DeleteListUsecase deleteListUsecase;
  final ShareListUsecase shareListUsecase;
  final GetListsUsecase getListUsecase;
  final AddProductOnListUsecase addProductUsecase;
  final DeleteProductOnListUsecase deleteProductUsecase;
  final UpdateProductOnListUsecase updateProductUsecase;

  ListDetailsPresenter({
    required this.createListUsecase,
    required this.getListUsecase,
    required this.deleteListUsecase,
    required this.shareListUsecase,
    required this.addProductUsecase,
    required this.deleteProductUsecase,
    required this.updateProductUsecase,
  });

  // Cuidar do comportamento do input de criar produto
  TextEditingController createProduct = TextEditingController(text: "");
  void onCleanText() => createProduct.text = "";
  String actualListId = "";

  Future<ShoppingListEntity?> getList() async {
    try {
      return await getListUsecase.getById(actualListId);
    } catch (e) {
      log("Não foi possível recuperar a lista atual");
      return null;
    }
  }

  Future<void> delete(String id) async {
    try {
      await deleteListUsecase.delete(id);
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
      );

      await createListUsecase.create(clonedList);
    } catch (e) {
      log("Não foi possível clonar a lista ${entity.id}");
    }
  }

  Future<void> share(ShoppingListEntity entity) async {
    try {
      await shareListUsecase.share(entity);
    } catch (e) {
      log("Erro ao compartilhar lista");
    }
  }

  Future<ShoppingListEntity> addProduct(ShoppingListEntity list) async {
    try {
      if (createProduct.text.isEmpty) {
        throw Exception("Escreva um nome para o produto");
      }
      var updatedList = await addProductUsecase.addProduct(
        list.id,
        ProductEntity(
          name: createProduct.text.trim(),
          id: generateMd5(createProduct.text),
        ),
      );

      return updatedList;
    } catch (e) {
      throw Exception("Não foi possível criar o produto");
    }
  }
}
