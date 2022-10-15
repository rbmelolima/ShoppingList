import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/factories/usecases/usecases.dart';
import 'package:shoppinglist/ui/pages/update_list/update_list_page.dart';
import 'package:shoppinglist/ui/pages/update_list/update_list_presenter.dart';

Widget makeUpdateListPage(ShoppingListEntity list) {
  UpdateListPresenter presenter = UpdateListPresenter(
    makeLocalUpdateList(),
    makeLocalDeleteList(),
  );

  return UpdateListPage(presenter: presenter, list: list);
}
