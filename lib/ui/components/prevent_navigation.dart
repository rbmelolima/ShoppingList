import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/style.dart';

Future<dynamic> preventNavigation(
  BuildContext context, {
  required String title,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          title,
          style: AppText.h5(AppColors.black01),
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, false);
            },
            child: Text(
              "Sim",
              style: AppText.btn(AppColors.black01),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Não",
              style: AppText.btn(AppColors.primary),
            ),
          ),
        ],
      );
    },
  );
}
