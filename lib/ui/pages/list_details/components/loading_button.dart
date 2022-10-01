import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 56,
      width: 56,
      child: const Center(
        child: SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
