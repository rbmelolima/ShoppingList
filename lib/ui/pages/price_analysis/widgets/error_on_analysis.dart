import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/color.dart';
import 'package:shoppinglist/ui/style/text.dart';

class ErrorOnAnalysis extends StatelessWidget {
  const ErrorOnAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ops, houve um problema ao pesquisar os preços da sua lista de compras. ",
                style: AppText.p(AppColors.black01, 18),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secundaryDark,
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Text("Voltar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
