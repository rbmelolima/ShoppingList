import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/helpers/button_state.dart';
import 'package:shoppinglist/ui/pages/list_details/components/components.dart';
import 'package:shoppinglist/ui/style/style.dart';

import './list_details_presenter.dart';

enum Options { clone, delete, share, edit }

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
  late ButtonState createButtonState;
  bool firstUpdate = true;

  @override
  void initState() {
    createButtonState = ButtonState.disable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstUpdate) {
      setState(() {
        firstUpdate = false;
        list = ModalRoute.of(context)!.settings.arguments as ShoppingListEntity;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScaffold,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: false,
        leading: const LeadingBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(context),
            if (list.products.isEmpty) ...[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const NotFoundProducts(),
              )
            ] else ...[
              ListView.builder(
                itemCount: list.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ResumeProductCard(product: list.products[index]);
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: double.maxFinite,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: AppColors.secundaryDark,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text("buscar menores preços".toUpperCase()),
                ),
              ),
            ],
            _buildWhiteSpace(),
          ],
        ),
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 96),
      padding: const EdgeInsets.all(16),
      color: AppColors.backgroundScaffold,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: TextField(
              decoration: const InputDecoration(
                hintText: "O que você gostaria de comprar?",
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => () {},
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
      var updated = await widget.presenter.addProduct(list);
      setState(() {
        createButtonState = ButtonState.enable;
        list = updated;
      });
    } catch (e) {
      log("Erro ao adicionar um produto.");
    } finally {
      setState(() {
        createButtonState = ButtonState.enable;
      });
      widget.presenter.onCleanText();
    }
  }

  Widget _buildWhiteSpace() => Container(height: 96);

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: Text(
              list.name.toString(),
              style: Theme.of(context).textTheme.headline3,
              softWrap: true,
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
            await widget.presenter.delete(list.id);
            if (mounted) {
              Navigator.pop(context);
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
            await widget.presenter.clone(list);
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
            await widget.presenter.share(list);
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
          try {} catch (e) {
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
