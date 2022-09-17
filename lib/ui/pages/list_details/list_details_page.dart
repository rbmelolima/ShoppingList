import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';

import 'list_details_presenter.dart';

class ListDetailsPage extends StatefulWidget {
  final ListDetailsPresenter presenter;

  const ListDetailsPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  late ShoppingListEntity list;

  @override
  void initState() {
    setState(() {
      list = ModalRoute.of(context)!.settings.arguments as ShoppingListEntity;
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(list.name.toString()),
          ],
        ),
      ),
    );
  }
}
