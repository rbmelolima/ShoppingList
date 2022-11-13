import 'package:flutter/material.dart';

import '../factories/pages/pages.dart';

class AppRoutes {
  static String rootPage = "/";
  static String myListsPage = "/minhas-listas";

  static Map<String, Widget Function(BuildContext)> mapOfRoutes = {
    rootPage: ((context) => makePreLoginPage()),
    myListsPage: ((context) => makeMyListsPage()),
  };
}
