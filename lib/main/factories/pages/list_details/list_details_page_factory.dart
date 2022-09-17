import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/pages/list_details/list_details.dart';

Widget makeListDetailsPage() {
  var presenter = ListDetailsPresenter();
  return ListDetailsPage(presenter: presenter);
}
