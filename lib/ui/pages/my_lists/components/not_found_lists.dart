import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/style.dart';

class NotFoundLists extends StatelessWidget {
  const NotFoundLists({
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
              "Parece que você ainda não criou nenhuma lista de compras...",
              style: AppText.p(AppColors.black01, 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
