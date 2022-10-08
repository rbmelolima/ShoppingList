import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/text.dart';

class DropdownBtn extends StatefulWidget {
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String hintText;
  final String? selected;

  const DropdownBtn({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.selected,
  }) : super(key: key);

  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: widget.items,
          onChanged: widget.onChanged,
          hint: Text(widget.hintText),
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
          ),
          iconSize: 16,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          style: AppText.input(
            const Color.fromRGBO(0, 0, 0, 1),
          ),
          value: widget.selected,
        ),
      ),
    );
  }
}
