import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/ui/pages/list_details/components/components.dart';
import 'package:shoppinglist/ui/pages/list_details/components/not_found_products.dart';
import 'package:shoppinglist/ui/style/style.dart';

import './list_details_presenter.dart';
import '../../components/leading_btn.dart';

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
  bool firstUpdate = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstUpdate) {
      setState(() {
        list = ModalRoute.of(context)!.settings.arguments as ShoppingListEntity;
        firstUpdate = false;
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
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(primary: AppColors.secundaryDark),
                child: Text("buscar menores preços".toUpperCase()),
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
              onChanged: (_) {},
            ),
          ),
          Container(
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
              onPressed: () {
                print("alo");
              },
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
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
