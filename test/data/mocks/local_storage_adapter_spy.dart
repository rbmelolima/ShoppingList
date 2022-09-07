import 'package:mocktail/mocktail.dart';
import 'package:shoppinglist/data/cache/cache_storage.dart';

class LocalStorageAdapterSpy extends Mock implements CacheStorage {
  When mockDeleteCall() => when(() => delete(any()));
  void mockDelete() => mockDeleteCall().thenAnswer((_) async => _);
  void mockDeleteError() => when(() => mockDeleteCall().thenThrow(Exception()));

  When mockSaveCall() =>
      when(() => save(key: any(named: "key"), value: any(named: "value")));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => when(() => mockSaveCall().thenThrow(Exception()));

  When mockDeleteAllCall() => when(() => deleteAll());
  void mockDeleteAll() => mockDeleteAllCall().thenAnswer((_) async => _);
  void mockDeleteAllError() =>
      when(() => mockDeleteAllCall().thenThrow(Exception()));

  When mockFetchCall(key) => when(() => fetch(key));
  void mockFetch(String key, dynamic data) =>
      mockFetchCall(key).thenAnswer((_) async => data);
  void mockFetchError() =>
      when(() => mockFetchCall(any()).thenThrow(Exception()));
}
