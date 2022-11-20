import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/style.dart';

class ErrorOnLoading extends StatelessWidget {
  final Function reload;

  const ErrorOnLoading({
    Key? key,
    required this.reload,
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
              "Ops, houve um problema em carregar suas listas",
              style: AppText.p(AppColors.black01, 18),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secundaryDark,
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.refresh_outlined),
                label: const Text("Tente novamente"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
