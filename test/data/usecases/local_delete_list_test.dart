import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/data/usecases/usecases.dart';
import 'package:test/test.dart';

import '../mocks/local_storage_adapter_spy.dart';

void main() {
  late LocalStorageAdapterSpy spy;
  late LocalDeleteList sut;

  setUp(() {
    spy = LocalStorageAdapterSpy();
    sut = LocalDeleteList(spy);
  });

  group("@delete", () {
    test(
      "Verifica se está, inicialmente, buscando todas as chaves em um dicionário",
      () async {
        spy.mockFetch("allKeys", null);
        spy.mockDelete();
        await sut.delete("id");
        verify(() => spy.fetch("allKeys")).called(1);
      },
    );

    test(
      "Verifica se está deletando a chave do dicionário",
      () async {
        spy.mockFetch("allKeys", jsonEncode(["id01", "id02", "id03"]));
        spy.mockDelete();
        spy.mockSave();
        await sut.delete("id02");
        verify(() =>
                spy.save(key: "allKeys", value: jsonEncode(["id01", "id03"])))
            .called(1);
      },
    );
    
    test(
      "Verifica se está deletando a chave do cacheStorage",
      () async {
        spy.mockFetch("allKeys", jsonEncode(["id01", "id02", "id03"]));
        spy.mockDelete();
        spy.mockSave();
        await sut.delete("id02");
        verify(() =>
                spy.save(key: "allKeys", value: jsonEncode(["id01", "id03"])))
            .called(1);
        verify(() => spy.delete("id02"));
      },
    );
  });

  group("@deleteAll", () {
    test("Verifica se está funcionando corretamente", () async {
      spy.mockDeleteAll();
      await sut.deleteAll();
      verify(() => spy.deleteAll()).called(1);
    });
  });
}
