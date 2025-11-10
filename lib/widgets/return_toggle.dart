import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

class ReturnToggle extends StatelessWidget {
  final ViewMode viewMode;
  final Function(ViewMode) onChanged;

  const ReturnToggle(
      {required this.viewMode, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [
        viewMode == ViewMode.amount,
        viewMode == ViewMode.percentage
      ],
      onPressed: (i) =>
          onChanged(i == 0 ? ViewMode.amount : ViewMode.percentage),
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("₹ Amount")),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("% Return")),
      ],
    );
  }
}
