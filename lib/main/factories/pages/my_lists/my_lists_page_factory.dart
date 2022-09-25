import 'package:flutter/material.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';
import 'package:shoppinglist/ui/pages/my_lists/my_lists.dart';

Widget makeMyListsPage() {
  MyListsPresenter presenter = MyListsPresenter(
    getUsecase: makeLocalGetLists(),
    createUsecase: makeLocalCreateList(),
    deleteUsecase: makeLocalDeleteList(),
    shareUsecase: makeExternalShareList(),
  );

  return MyListsPage(presenter: presenter);
}
