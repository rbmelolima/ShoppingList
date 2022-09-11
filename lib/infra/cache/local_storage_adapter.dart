import '../../data/cache/cache.dart';

import 'package:localstorage/localstorage.dart';

class LocalStorageAdapter implements CacheStorage {
  final LocalStorage localStorage;

  LocalStorageAdapter({required this.localStorage});

  Future<bool> _isReady() async => await localStorage.ready;

  @override
  Future<void> save({required String key, required dynamic value}) async {
    var ready = await _isReady();

    if (ready) {
      await localStorage.deleteItem(key);
      await localStorage.setItem(key, value);
    }
  }

  @override
  Future<void> delete(String key) async {
    var ready = await _isReady();

    if (ready) {
      await localStorage.deleteItem(key);
    }
  }

  @override
  Future<void> deleteAll() async {
    var ready = await _isReady();

    if (ready) {
      await localStorage.clear();
    }
  }

  @override
  Future<dynamic> fetch(String key) async {
    var ready = await _isReady();

    if (ready) {
      return await localStorage.getItem(key);
    }
  }
}
