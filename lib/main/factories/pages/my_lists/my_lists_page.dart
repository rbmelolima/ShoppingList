import 'package:flutter/material.dart';
import 'package:shoppinglist/main/factories/usecases/local_get_list_factory.dart';
import 'package:shoppinglist/ui/pages/my_lists/my_lists.dart';

Widget makeMyListsPage() {
  MyListsPresenter presenter = MyListsPresenter(
    getUsecase: makeLocalGetLists(),
  );

  return MyListsPage(presenter: presenter);
}
