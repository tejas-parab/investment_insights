import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

class SortDropdown extends StatelessWidget {
  final SortBy value;
  final Function(SortBy?) onChanged;

  const SortDropdown({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortBy>(
      value: value,
      items: [
        DropdownMenuItem(value: SortBy.name, child: Text("Name")),
        DropdownMenuItem(value: SortBy.value, child: Text("Value")),
        DropdownMenuItem(value: SortBy.gain, child: Text("Gain")),
      ],
      onChanged: onChanged,
      hint: Text("Sort by"),
    );
  }
}
