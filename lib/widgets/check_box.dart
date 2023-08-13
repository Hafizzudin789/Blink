import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const CheckBoxWidget({super.key, required this.value, required this.onChanged});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: widget.value
              ? yellowColor
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: gray300Color),
        ),
        child: widget.value
            ? const Icon(Icons.done)
            : const SizedBox(),
      ),
    );
  }
}
