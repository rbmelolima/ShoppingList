import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/helpers/button_state.dart';
import 'package:shoppinglist/ui/pages/list_details/components/components.dart';
import 'package:shoppinglist/ui/style/style.dart';

import './list_details_presenter.dart';

enum Options { clone, delete, share, edit }

class ListDetailsPage extends StatefulWidget {
  final ListDetailsPresenter presenter;
  final ShoppingListEntity list;

  const ListDetailsPage({
    Key? key,
    required this.presenter,
    required this.list,
  }) : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  late ShoppingListEntity _list;
  late ButtonState createButtonState;
  late FocusNode productTextFieldFocus;
  bool firstUpdate = true;

  @override
  void initState() {
    createButtonState = ButtonState.disable;
    widget.presenter.actualListId = widget.list.id;
    productTextFieldFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    productTextFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (firstUpdate) {
      setState(() {
        firstUpdate = false;
        _list = widget.list;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundScaffold,
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 40,
          centerTitle: false,
          leading: LeadingBtn(
            onBack: () => Navigator.pop(context, true),
          ),
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0 &&
              _list.products.length > 1,
          child: FloatingActionButton.extended(
            onPressed: () async {
              await AppNavigation.navigateToPriceAnalysis(
                context,
                widget.list,
              );
            },
            backgroundColor: AppColors.secundaryDark,
            label: const Text("Buscar preços"),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(context),
                _buildAddProductsField(),
                if (_list.products.isEmpty) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const NotFoundProducts(),
                  )
                ] else ...[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _list.products.length,
                    itemBuilder: (context, index) {
                      return ResumeProductCard(
                        product: _list.products[index],
                        idList: _list.id,
                        onUpdatePage: () async {
                          var updatedList = await widget.presenter.getList();
                          if (updatedList != null) {
                            setState(() {
                              _list = updatedList;
                            });
                          }
                        },
                      );
                    },
                  ),
                ],
                _buildWhiteSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddProductsField() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 96),
      margin: const EdgeInsets.only(bottom: 24),
      color: AppColors.backgroundScaffold,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: TextField(
              focusNode: productTextFieldFocus,
              decoration: const InputDecoration(
                hintText: "O que você gostaria de comprar?",
              ),
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              onSubmitted: null,
              onEditingComplete: () {
                onAddProduct();
              },
              controller: widget.presenter.createProduct,
              maxLines: 1,
              onChanged: (_) {
                if (widget.presenter.createProduct.text.isNotEmpty) {
                  setState(() {
                    createButtonState = ButtonState.enable;
                  });
                } else {
                  setState(() {
                    createButtonState = ButtonState.disable;
                  });
                }
              },
            ),
          ),
          Builder(
            builder: (context) {
              if (createButtonState == ButtonState.loading) {
                return const LoadingButton();
              }
              return Container(
                margin: const EdgeInsets.only(left: 16),
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(56),
                  ),
                ),
                child: IconButton(
                  color: Colors.white,
                  disabledColor: Colors.white,
                  onPressed: createButtonState == ButtonState.enable
                      ? onAddProduct
                      : null,
                  icon: const Icon(Icons.add),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> onAddProduct() async {
    try {
      setState(() {
        createButtonState = ButtonState.loading;
      });
      var updated = await widget.presenter.addProduct(_list);
      setState(() {
        createButtonState = ButtonState.enable;
        _list = updated;
      });
      productTextFieldFocus.requestFocus();
    } catch (e) {
      log("Erro ao adicionar um produto.");
      productTextFieldFocus.unfocus();
    } finally {
      setState(() {
        createButtonState = ButtonState.enable;
      });
      widget.presenter.onCleanText();
    }
  }

  Widget _buildWhiteSpace() => Container(height: 52);

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _list.name.toString(),
                  style: Theme.of(context).textTheme.headline3,
                  softWrap: true,
                ),
                if (_list.description != null && _list.description != "")
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      _list.description.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          PopupMenuButton<Options>(
            icon: const Icon(Icons.settings),
            itemBuilder: (context) => _generatePopupItensList,
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry<Options>> get _generatePopupItensList {
    return <PopupMenuEntry<Options>>[
      PopupMenuItem<Options>(
        value: Options.delete,
        onTap: () async {
          try {
            await widget.presenter.delete(_list.id);
            if (mounted) {
              Navigator.pop(context, true);
            }
          } catch (e) {
            log(e.toString());
          }
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.delete,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Excluir',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
      PopupMenuItem<Options>(
        value: Options.clone,
        onTap: () async {
          try {
            await widget.presenter.clone(_list);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Lista clonada com sucesso!"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Não foi possível clonar a lista"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.copy,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Clonar',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
      PopupMenuItem<Options>(
        value: Options.share,
        onTap: () async {
          try {
            await widget.presenter.share(_list);
          } catch (e) {
            log(e.toString());
          }
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.share,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Compartilhar',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
      PopupMenuItem<Options>(
        value: Options.edit,
        onTap: () async {
          try {
            await Future.delayed(Duration.zero, () async {
              await AppNavigation.navigateToUpdateList(context, _list);

              var updatedList = await widget.presenter.getList();
              if (updatedList != null) {
                setState(() {
                  _list = updatedList;
                });
              }
            });
          } catch (e) {
            log(e.toString());
          }
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.edit,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Editar',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
    ];
  }
}
