import 'dart:developer';

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
      await localStorage.setItem(key, value);
    } else {
      log("@lsError LocalStorage is not ready");
    }
  }

  @override
  Future<void> delete(String key) async {
    var ready = await _isReady();

    if (ready) {
      await localStorage.deleteItem(key);
    } else {
      log("@lsError LocalStorage is not ready");
    }
  }

  @override
  Future<void> deleteAll() async {
    var ready = await _isReady();

    if (ready) {
      await localStorage.clear();
    } else {
      log("@lsError LocalStorage is not ready");
    }
  }

  @override
  Future<dynamic> fetch(String key) async {
    var ready = await _isReady();

    if (ready) {
      return await localStorage.getItem(key);
    } else {
      log("@lsError LocalStorage is not ready");
    }
  }
}
