import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/domain/usecases/get_lists_usecase.dart';

class MyListsPresenter {
  final GetListsUsecase getUsecase;

  MyListsPresenter({
    required this.getUsecase,
  });

  Stream<List<ShoppingListEntity>?> get listsStream => _lists.stream;

  final StreamController<List<ShoppingListEntity>?> _lists = StreamController();

  Future<void> loadData() async {
    try {
      var data = await getUsecase.getAll();
      _lists.add(data);
    } catch (e) {
      _lists.addError(e);
    }
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
