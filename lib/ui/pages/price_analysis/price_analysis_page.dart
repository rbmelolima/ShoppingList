import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/domain/entities/supplier_entity.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/pages/price_analysis/price_analysis_presenter.dart';
import 'package:shoppinglist/ui/style/style.dart';

import 'widgets/widgets.dart';

class PriceAnalysisPage extends StatefulWidget {
  final PriceAnalysisPresenter presenter;
  final ShoppingListEntity shoppingList;

  const PriceAnalysisPage({
    Key? key,
    required this.presenter,
    required this.shoppingList,
  }) : super(key: key);

  @override
  State<PriceAnalysisPage> createState() => _PriceAnalysisPageState();
}

class _PriceAnalysisPageState extends State<PriceAnalysisPage> {
  String actualValue = "R\$ 80,00";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SupplierEntity>>(
      future: widget.presenter.analysis(widget.shoppingList),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingAnalysis();
        }

        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.hasData) {
          return _buildBody(context, snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, List<SupplierEntity> data) {
    List<Widget> tabs = [];
    List<Widget> pages = [];

    for (int i = 0; i < data.length; i++) {
      String subtitle = data[i].isBetterOption ? "Melhor Opção" : "Opção ${i + 1}";
      tabs.add(
        Tab(
          text: subtitle,
          icon: const Icon(Icons.shopping_cart),
          iconMargin: const EdgeInsets.only(bottom: 4),
          height: 72,
        ),
      );

      pages.add(
        buildOptionPage(data[i], subtitle),
      );
    }

    return DefaultTabController(
      length: data.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Análise de preços"),
          leadingWidth: 40,
          centerTitle: false,
          leading: LeadingBtn(
            color: Colors.white,
            onBack: () => Navigator.pop(context),
          ),
          bottom: TabBar(tabs: tabs),
        ),
        backgroundColor: AppColors.backgroundScaffold,
        body: TabBarView(children: pages),
        bottomSheet: Container(
          child: Row(children: [Text("Preço Total $actualValue")]),
        ),
      ),
    );
  }

  Widget buildOptionPage(SupplierEntity supplier, String subtitle) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            supplier.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            subtitle,
            style: AppText.h5(
              subtitle.toUpperCase().contains("MELHOR") ? AppColors.secundaryDark : AppColors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              supplier.products[index].name,
                              style: AppText.h5(
                                AppColors.primaryDark,
                              ),
                            ),
                            Text(
                              supplier.products[index].description ?? "",
                              style: AppText.p(
                                AppColors.black03,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: Chip(
                          backgroundColor: AppColors.primaryLight,
                          labelStyle: AppText.chip(AppColors.primaryDark),
                          label: Text(
                            supplier.totalPrice,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Color(0xFFB7B7B7),
                  height: 24,
                );
              },
              itemCount: supplier.products.length,
            ),
          ),
        ],
      ),
    );
  }
}
