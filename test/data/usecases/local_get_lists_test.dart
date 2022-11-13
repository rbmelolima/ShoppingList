import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/data/usecases/local_get_list.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:test/test.dart';

import '../../domain/mocks/shopping_list_mock.dart';
import '../mocks/local_storage_adapter_spy.dart';

void main() {
  late LocalGetLists sut;
  late LocalStorageAdapterSpy spy;

  setUp(() {
    spy = LocalStorageAdapterSpy();
    sut = LocalGetLists(spy);
  });

  group("@getById", () {
    test(
      "Verifica se está chamando o cacheStorage com os valores corretos",
      () async {
        spy.mockFetch("id", null);
        await sut.getById("id");
        verify(() => spy.fetch("id")).called(1);
      },
    );

    test(
      "Verifica se está retornando nulo caso nenhuma chave seja compatível",
      () async {
        spy.mockFetch("id", null);
        var res = await sut.getById("id");
        expect(res, null);
      },
    );

    test(
      "Verifica se está retornando um ShoppingListEntity caso seja encontrado",
      () async {
        spy.mockFetch("id", generateShoppingListEntityMock().toJson());
        var res = await sut.getById("id");
        expect(res, isA<ShoppingListEntity>());
      },
    );
  });

  group("@getAll", () {
    test(
      "Verifica se está, inicialmente, buscando todas as chaves em um dicionário",
      () async {
        spy.mockFetch("allKeys", null);
        await sut.getAll();
        verify(() => spy.fetch("allKeys")).called(1);
      },
    );

    test(
      "Se o dicionário de chaves estiver vazio, verifica se retorna nulo",
      () async {
        spy.mockFetch("allKeys", null);
        var res = await sut.getAll();
        expect(res, null);
      },
    );

    test(
      "Verifica se o cacheStorage está sendo chamado conforme a quantidade de chaves no dicionário",
      () async {
        spy.mockFetch("allKeys", jsonEncode(["id01", "id02", "id03"]));
        spy.mockFetch("id01", generateShoppingListEntityMock().toJson());
        spy.mockFetch("id02", generateShoppingListEntityMock().toJson());
        spy.mockFetch("id03", generateShoppingListEntityMock().toJson());

        var res = await sut.getAll();

        verify(() => spy.fetch("allKeys")).called(1);
        verify(() => spy.fetch("id01")).called(1);
        verify(() => spy.fetch("id02")).called(1);
        verify(() => spy.fetch("id03")).called(1);
        expect(res!.length, 3);
      },
    );

    test(
      "Verifica se todas as listas que conseguirem retornar do cacheStorage estão sendo entregues ao usuário",
      () async {
        spy.mockFetch("allKeys", jsonEncode(["id01", "id02", "id03"]));
        spy.mockFetch("id01", generateShoppingListEntityMock().toJson());
        spy.mockFetch("id02", null);
        spy.mockFetch("id03", generateShoppingListEntityMock().toJson());

        var res = await sut.getAll();

        verify(() => spy.fetch("allKeys")).called(1);
        verify(() => spy.fetch("id01")).called(1);
        verify(() => spy.fetch("id02")).called(1);
        verify(() => spy.fetch("id03")).called(1);
        expect(res!.length, 2);
      },
    );
  });
}
