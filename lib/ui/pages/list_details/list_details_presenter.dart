import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/usecases.dart';
import 'package:shoppinglist/utils/generate_md5.dart';

class ListDetailsPresenter {
  final CreateListUsecase createUsecase;
  final DeleteListUsecase deleteUsecase;
  final ShareListUsecase shareUsecase;
  final AddProductOnListUsecase addProductUsecase;
  final DeleteProductOnListUsecase deleteProductUsecase;
  final UpdateProductOnListUsecase updateProductUsecase;

  ListDetailsPresenter({
    required this.createUsecase,
    required this.deleteUsecase,
    required this.shareUsecase,
    required this.addProductUsecase,
    required this.deleteProductUsecase,
    required this.updateProductUsecase,
  });

  // Cuidar do comportamento do input de criar produto
  TextEditingController createProduct = TextEditingController(text: "");
  void onCleanText() => createProduct.text = "";

  late ShoppingListEntity list;

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

  Future<void> addProduct(ShoppingListEntity list) async {
    try {
      if (createProduct.text.isEmpty) {
        throw Exception("Escreva um nome para o produto");
      }
      await addProductUsecase.addProduct(
        list.id,
        ProductEntity(
          name: createProduct.text,
          id: generateMd5(createProduct.text),
        ),
      );
    } catch (e) {
      throw Exception("Não foi possível criar o produto");
    }
  }
}
