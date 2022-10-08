import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/product_entity.dart';
import 'package:shoppinglist/ui/components/dropdown_btn.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/pages/update_product/update_product.dart';
import 'package:shoppinglist/ui/style/color.dart';

const List<String> quantifiers = [
  "unidade(s)",
  "ml",
  "l",
  "cm",
  "kg",
  "g",
  "mg",
];

class UpdateProductPage extends StatefulWidget {
  final UpdateProductPresenter presenter;
  final ProductEntity product;

  const UpdateProductPage({
    Key? key,
    required this.presenter,
    required this.product,
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
        leading: const LeadingBtn(),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 36),
              child: Text(
                "Sobre o\nProduto",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                controller: widget.presenter.productName,
                decoration: const InputDecoration(
                  hintText: "Nome do produto",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: widget.presenter.productQuantifierValue,
                    decoration: const InputDecoration(
                      hintText: "Quantidade, volume, etc",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 0.05),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: DropdownBtn(
                      items: quantifiers
                          .map<DropdownMenuItem<String>>((String value) {
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
                decoration: const InputDecoration(
                  hintText: "Marca do produto",
                ),
              ),
            ),
            TextFormField(
              maxLines: 6,
              controller: widget.presenter.productDetails,
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
                  await widget.presenter.save();
                },
                child: Text("salvar".toUpperCase()),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () {},
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
