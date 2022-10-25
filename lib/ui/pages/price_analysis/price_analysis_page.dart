import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/shopping_list_entity.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/pages/price_analysis/price_analysis_presenter.dart';
import 'package:shoppinglist/ui/style/color.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.presenter.analysis(widget.shoppingList),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingAnalysis();
        }

        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Análise de preços"),
              leadingWidth: 40,
              centerTitle: false,
              leading: LeadingBtn(
                color: Colors.white,
                onBack: () => Navigator.pop(context),
              ),
            ),
            backgroundColor: AppColors.backgroundScaffold,
            body: Container(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
