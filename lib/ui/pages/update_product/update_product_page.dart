import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/style/color.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Sobre o\nProduto",
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
