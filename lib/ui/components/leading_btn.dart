import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/color.dart';

class LeadingBtn extends StatelessWidget {
  const LeadingBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      padding: const EdgeInsets.all(0),
      splashRadius: 1,
      icon: Icon(
        Icons.chevron_left,
        color: AppColors.black01,
      ),
    );
  }
}
