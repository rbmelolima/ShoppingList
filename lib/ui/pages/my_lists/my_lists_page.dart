import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/ui/helpers/helpers.dart';
import 'package:shoppinglist/ui/pages/my_lists/my_lists.dart';
import 'package:shoppinglist/ui/style/style.dart';

import 'components/components.dart';

class MyListsPage extends StatefulWidget {
  final MyListsPresenter presenter;
  const MyListsPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  @override
  void initState() {
    log("Carregando as listas");
    widget.presenter.getAllLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas listas"),
        actions: [
          IconButton(
            onPressed: () {
              widget.presenter.getAllLists();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          widget.presenter.getAllLists();

          return StreamBuilder<List<ShoppingListEntity>?>(
            stream: widget.presenter.listsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorOnLoading(
                  reload: () async => await widget.presenter.getAllLists(),
                );
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
                                  await widget.presenter.delete(
                                    snapshot.data![index].id,
                                  );
                                },
                                onClone: () async {
                                  await widget.presenter
                                      .clone(snapshot.data![index]);
                                },
                                onShare: () async {
                                  await widget.presenter
                                      .share(snapshot.data![index]);
                                },
                                onUpdatePage: () async {
                                  await widget.presenter.getAllLists();
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
    widget.presenter.onCleanText();

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
                      textCapitalization: TextCapitalization.words,
                      onSubmitted: (_) => onCloseKeyboard(context),
                      controller: widget.presenter.createListName,
                      maxLines: 1,
                      onChanged: (_) {
                        if (widget.presenter.createListName.text.isNotEmpty) {
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
                                  widget
                                      .presenter.createListName.text.isNotEmpty
                              ? () async {
                                  try {
                                    setState(() {
                                      btnState = ButtonState.loading;
                                    });
                                    var list = await widget.presenter.create();
                                    setState(() {
                                      btnState = ButtonState.enable;
                                    });

                                    if (!mounted) return;
                                    FocusScope.of(context).unfocus();
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
                            foregroundColor: AppColors.primary,
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
