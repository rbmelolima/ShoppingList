import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/ui/pages/my_lists/my_lists.dart';

import 'components/components.dart';

class MyListsPage extends StatelessWidget {
  final MyListsPresenter presenter;
  const MyListsPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas listas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            presenter.loadData();

            return StreamBuilder<List<ShoppingListEntity>?>(
              stream: presenter.listsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(); //Error Widget
                }

                if (snapshot.hasData) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container(); // Nothing Widget
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator(); // Loading Widget
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ResumeListCard(
                            name: snapshot.data![index].name,
                            lenght: snapshot.data![index].products.length,
                            products: snapshot.data![index].products,
                          );
                        },
                      ); // Constructive Widget
                  }
                } else {
                  return Container(); // Nothing Widget
                }
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(
            MediaQuery.of(context).size.width - paddingHorizontal,
            64,
          ),
          padding: const EdgeInsets.symmetric(vertical: 22),
        ),
        child: Text("Nova lista".toUpperCase()),
      ),
    );
  }
}
