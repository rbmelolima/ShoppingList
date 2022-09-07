import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:test/test.dart';

import '../../domain/mocks/shopping_list_mock.dart';
import '../mocks/local_storage_adapter_spy.dart';

void main() {
  late LocalStorageAdapterSpy spy;
  late LocalCreateList sut;
  late ShoppingListEntity shoppingList;

  setUp(() {
    spy = LocalStorageAdapterSpy();
    sut = LocalCreateList(spy);
    shoppingList = generateShoppingListEntityMock();
  });

  test(
    "Verifica se está, inicialmente, buscando todas as chaves em um dicionário",
    () async {
      spy.mockFetch("allKeys", null);
      spy.mockSave();
      await sut.create(shoppingList);
      verify(() => spy.fetch("allKeys")).called(1);
    },
  );

  test(
    "Verifica se está criando um dicionário de chaves, caso o mesmo não exista",
    () async {
      spy.mockFetch("allKeys", null);
      spy.mockSave();
      await sut.create(shoppingList);
      verify(
        () => spy.save(
            key: "allKeys",
            value: jsonEncode(
              [shoppingList.id],
            )),
      ).called(1);
    },
  );

  test(
    "Verifica se está adicionando o id do produto atual no dicionário de chaves",
    () async {
      spy.mockFetch("allKeys", jsonEncode(["id01"]));
      spy.mockSave();
      await sut.create(shoppingList);
      verify(
        () => spy.save(
            key: "allKeys",
            value: jsonEncode(
              ["id01", shoppingList.id],
            )),
      ).called(1);
    },
  );

  test(
    "Verifica se está salvando a lista no cacheStorage",
    () async {
      spy.mockFetch("allKeys", jsonEncode(["id01"]));
      spy.mockSave();
      await sut.create(shoppingList);
      verify(
        () => spy.save(
            key: "allKeys",
            value: jsonEncode(
              ["id01", shoppingList.id],
            )),
      ).called(1);

      verify(
        () => spy.save(key: shoppingList.id, value: shoppingList.toJson()),
      ).called(1);
    },
  );
}
