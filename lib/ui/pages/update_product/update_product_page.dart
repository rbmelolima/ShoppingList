import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/ui/components/dropdown_btn.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/components/prevent_navigation.dart';
import 'package:shoppinglist/ui/pages/update_product/update_product.dart';
import 'package:shoppinglist/ui/style/color.dart';

const List<String> quantifiers = [
  "unidade(s)",
  "ml",
  "l",
  "mg",
  "g",
  "kg",
  "caixa(s)",
  "embalagem(ns)",
  "garrafa(s)",
  "lata(s)",
  "pacote(s)",
  "galão(ões)",
];

class UpdateProductPage extends StatefulWidget {
  final UpdateProductPresenter presenter;
  final ProductEntity product;
  final String idList;

  const UpdateProductPage({
    Key? key,
    required this.presenter,
    required this.product,
    required this.idList,
  }) : super(key: key);

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.presenter.fill(widget.product);
    super.initState();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScaffold,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: false,
        leading: LeadingBtn(
          onBack: () {
            if (widget.presenter.isEditing) {
              preventNavigation(
                context,
                title: 'Alerta',
                content: "Você ainda não terminou de editar o produto.\n\nDeseja realmente sair?",
              );
            } else {
              if (widget.presenter.wasEdited) Navigator.pop(context, true);
              if (!widget.presenter.wasEdited) Navigator.pop(context, false);
            }
          },
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 36),
              child: Text(
                "Sobre o Produto",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                controller: widget.presenter.productName,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onChanged: (_) {
                  widget.presenter.isEditing = true;
                },
                decoration: const InputDecoration(
                  hintText: "Nome do produto",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: widget.presenter.productQuantifierValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    onChanged: (_) {
                      setState(() {
                        widget.presenter.isEditing = true;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Quantidade, volume, etc",
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(left: 12),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 0.05),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: DropdownBtn(
                      items: quantifiers.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hintText: quantifiers.first,
                      selected: widget.presenter.productQuantifierType,
                      onChanged: (val) {
                        setState(() {
                          widget.presenter.productQuantifierType = val;
                          widget.presenter.isEditing = true;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                controller: widget.presenter.productBrand,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onChanged: (_) {
                  setState(() {
                    widget.presenter.isEditing = true;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Marca do produto",
                ),
              ),
            ),
            TextFormField(
              maxLines: 3,
              controller: widget.presenter.productDetails,
              textInputAction: TextInputAction.done,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              onChanged: (_) {
                setState(() {
                  widget.presenter.isEditing = true;
                });
              },
              decoration: const InputDecoration(
                hintText: "Outros detalhes, como cor, característica, etc",
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Quanto mais informações o produto tiver, menos gerérica será a pesquisa pelo menor preço.",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(bottom: 16, top: 12),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    FocusScope.of(context).unfocus();
                    await widget.presenter.save(widget.idList);
                    if (mounted) Navigator.pop(context, true);
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Não foi possível salvar as alterações",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text("salvar".toUpperCase()),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () async {
                  try {
                    await widget.presenter.delete(widget.idList);
                    if (mounted) Navigator.pop(context, true);
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Não foi possível excluir o produto",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text("excluir produto".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
