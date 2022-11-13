import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/infra/cache/cache.dart';
import 'package:test/test.dart';

import '../mocks/local_storage_spy.dart';

void main() {
  late LocalStorageAdapter sut;
  late LocalStorageSpy localStorage;
  late String key;
  late dynamic value;
  late String result;

  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    result = faker.randomGenerator.string(50);
    localStorage = LocalStorageSpy();
    localStorage.mockFetch(result);
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  group('@save', () {
    test('Deve chamar o LocalStorage com os valores corretos', () async {
      await sut.save(key: key, value: value);

      verify(() => localStorage.setItem(key, value)).called(1);
    });
  });

  group('@delete', () {
    test('Deve chamar o LocalStorage com os valores corretos', () async {
      await sut.delete(key);

      verify(() => localStorage.deleteItem(key)).called(1);
    });

    test('Deve lançar uma exceção caso o @deleteitem quebre', () async {
      localStorage.mockDeleteError();

      final future = sut.delete(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('@deleteAll', () {
    test('Deve chamar o LocalStorage corretamente', () async {
      await sut.deleteAll();

      verify(() => localStorage.clear()).called(1);
    });

    test('Deve lançar uma exceção caso o @clear quebre', () async {
      localStorage.mockDeleteAllError();

      final future = sut.deleteAll();

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('@fetch', () {
    test('Deve chamar o LocalStorage com os valores corretos', () async {
      await sut.fetch(key);

      verify(() => localStorage.getItem(key)).called(1);
    });

    test('Deve retornar os valores corretos que estão no LocalStorage',
        () async {
      final data = await sut.fetch(key);

      expect(data, result);
    });

    test('Deve lançar uma exceção caso o @getitem quebre', () async {
      localStorage.mockFetchError();

      final future = sut.fetch(key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
