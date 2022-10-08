import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/main/routes/routes.dart';
import 'package:shoppinglist/ui/helpers/helpers.dart';
import 'package:shoppinglist/ui/pages/my_lists/my_lists.dart';
import 'package:shoppinglist/ui/style/style.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              presenter.getAllLists();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          presenter.getAllLists();

          return StreamBuilder<List<ShoppingListEntity>?>(
            stream: presenter.listsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(); //Error Widget
              }

              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator(); // Loading Widget
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.data!.isEmpty) {
                      return const NotFoundLists();
                    }
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ResumeListCard(
                                list: snapshot.data![index],
                                onDelete: () async {
                                  await presenter.delete(
                                    snapshot.data![index].id,
                                  );
                                },
                                onClone: () async {
                                  await presenter.clone(snapshot.data![index]);
                                },
                                onShare: () async {
                                  await presenter.share(snapshot.data![index]);
                                },
                              );
                            },
                          ),
                          _buildWhiteSpace(),
                        ],
                      ),
                    ); // Constructive Widget
                }
              } else {
                return const NotFoundLists();
              }
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () => onCreateList(context),
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

  Widget _buildWhiteSpace() => Container(height: 96);

  dynamic onCreateList(BuildContext context) {
    presenter.onCleanText();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context, [bool mounted = true]) {
        ButtonState btnState = ButtonState.disable;

        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: (MediaQuery.of(context).viewInsets.bottom + 16),
                top: 24,
                left: 16,
                right: 16,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "+ Nova Lista",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32, bottom: 16),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Qual o nome da sua lista de compras?",
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => onCloseKeyboard(context),
                      controller: presenter.createListName,
                      maxLines: 1,
                      onChanged: (_) {
                        if (presenter.createListName.text.isNotEmpty) {
                          setState(() {
                            btnState = ButtonState.enable;
                          });
                        } else {
                          setState(() {
                            btnState = ButtonState.disable;
                          });
                        }
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (btnState == ButtonState.loading) {
                        return const Center(
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: btnState == ButtonState.enable ||
                                  presenter.createListName.text.isNotEmpty
                              ? () async {
                                  try {
                                    setState(() {
                                      btnState = ButtonState.loading;
                                    });
                                    var list = await presenter.create();
                                    setState(() {
                                      btnState = ButtonState.enable;
                                    });

                                    if (!mounted) return;
                                    Navigator.pop(context);
                                    AppNavigation.navigateToListDetails(
                                      context,
                                      list,
                                    );
                                  } catch (e) {
                                    if (!mounted) return;
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                          ),
                          child: Text(
                            "Criar lista",
                            style: AppText.btn(Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
