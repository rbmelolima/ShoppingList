import 'package:flutter/material.dart';

class AppRoutes {
  static String rootPage = "/";
  static String myListsPage = "/minhas-listas";

  static Map<String, Widget Function(BuildContext)> mapOfRoutes = {
    rootPage: ((context) => Container()),
    myListsPage: ((context) => Container()),
  };
}
