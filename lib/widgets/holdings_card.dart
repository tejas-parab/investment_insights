import 'package:flutter/material.dart';
import '../../models/portfolio_model.dart';
import '../screens/dashboard_screen.dart'; // Import ViewMode

class HoldingsCard extends StatelessWidget {
  final Holding holding;
  final ViewMode viewMode;

  const HoldingsCard(
      {required this.holding, required this.viewMode, super.key});

  @override
  Widget build(BuildContext context) {
    final gainColor = holding.gain >= 0 ? Colors.green : Colors.red;
    final gainIcon =
        holding.gain >= 0 ? Icons.trending_up : Icons.trending_down;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: gainColor.withOpacity(0.1),
          child: Icon(gainIcon, color: gainColor),
        ),
        title: Text(holding.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(holding.symbol),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹${holding.currentValue.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              viewMode == ViewMode.amount
                  ? "${holding.gain >= 0 ? '+' : ''}₹${holding.gain.abs().toStringAsFixed(0)}"
                  : "${holding.gainPercentage >= 0 ? '+' : ''}${holding.gainPercentage.toStringAsFixed(1)}%",
              style: TextStyle(color: gainColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
