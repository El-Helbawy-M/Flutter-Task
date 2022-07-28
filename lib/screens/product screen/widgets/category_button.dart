import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(this.text, this.onTap, {Key? key, this.isSelected = false}) : super(key: key);
  final String text;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: (isSelected) ? const BorderSide(width: 1, color: Colors.yellow) : BorderSide.none),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(text),
        ),
      ),
    );
  }
}
