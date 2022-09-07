import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppinglist/main/routes/routes.dart';
import 'package:shoppinglist/ui/assets/assets_helper.dart';

class PreLoginPage extends StatelessWidget {
  const PreLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = 32;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 425),
              child: SvgPicture.asset(
                pathOfAsset(Assets.illustrationPreLogin),
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 12),
              child: Text(
                "Lista de compras inteligente",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Text(
              "Crie e gerencie diversas listas de compras, sabendo onde comprar seus produtos pelo menor preço!",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, AppRoutes.myListsPage),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            MediaQuery.of(context).size.width - paddingHorizontal,
            64,
          ),
          padding: const EdgeInsets.symmetric(vertical: 22),
        ),
        child: Text("Vamos lá!".toUpperCase()),
      ),
    );
  }
}
