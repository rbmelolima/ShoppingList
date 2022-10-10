import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/color.dart';

class LeadingBtn extends StatelessWidget {
  final Function? onBack;

  const LeadingBtn({
    Key? key,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onBack == null) {
          Navigator.pop(context);
        } else {
          onBack!();
        }
      },
      padding: const EdgeInsets.all(0),
      splashRadius: 1,
      icon: Icon(
        Icons.chevron_left,
        color: AppColors.black01,
      ),
    );
  }
}
