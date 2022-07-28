import 'package:flutter/material.dart';

import '../../../tools/app_localizer.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
    this.title,
    this.icon,
    this.onTap, {
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        Icon(icon, color: Colors.white),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(getLang(context, title), style: TextStyle(color: Colors.white)),
        ),
      ]),
    );
  }
}
