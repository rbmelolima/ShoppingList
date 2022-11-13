import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppinglist/ui/assets/assets_helper.dart';
import 'package:shoppinglist/ui/style/color.dart';

class LoadingAnalysis extends StatelessWidget {
  const LoadingAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              pathOfLottie(Assets.illustrationLoadingAnalysis),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Procurando os\nmenores preços",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Text(
              "Aguarde um pouquinho, estamos\nanalisando os menores preços...",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
