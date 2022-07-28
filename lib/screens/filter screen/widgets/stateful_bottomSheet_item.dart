import 'package:flutter/material.dart';

class StatefulBottomSheetItem extends StatefulWidget {
  const StatefulBottomSheetItem(
    this.value,
    this.onChange,
    this.check, {
    Key? key,
  }) : super(key: key);
  final bool check;
  final String value;
  final Function(String) onChange;
  @override
  State<StatefulBottomSheetItem> createState() => _StatefulBottomSheetItemState();
}

class _StatefulBottomSheetItemState extends State<StatefulBottomSheetItem> {
  late bool check;
  @override
  void initState() {
    check = widget.check;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.value),
      onChanged: (bool? value) {
        widget.onChange(widget.value);
        setState(() {
          check = !check;
        });
      },
      value: check,
      activeColor: Colors.orange,
    );
  }
}
