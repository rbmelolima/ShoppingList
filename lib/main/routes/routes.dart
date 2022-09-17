import 'package:flutter/material.dart';

import '../factories/pages/pages.dart';

class AppRoutes {
  static String rootPage = "/";
  static String myListsPage = "/minhas-listas";
  static String listDetails = "/detalhes-da-lista";

  static Map<String, Widget Function(BuildContext)> mapOfRoutes = {
    rootPage: ((context) => makePreLoginPage()),
    myListsPage: ((context) => makeMyListsPage()),
    listDetails: ((context) => makeListDetailsPage()),
  };
}
