import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/style.dart';

class NotFoundProducts extends StatelessWidget {
  const NotFoundProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Parece que você ainda não adicionou nenhum produto...",
              style: AppText.p(AppColors.black01, 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
