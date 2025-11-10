// lib/widgets/header_widget.dart
import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';

class HeaderWidget extends StatelessWidget {
  final UserPortfolio portfolio;
  final String username;

  const HeaderWidget({
    required this.portfolio,
    required this.username,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, $username",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const Text("Total Portfolio Value",
                style: TextStyle(color: Colors.grey)),
            Text("₹${portfolio.portfolioValue.toStringAsFixed(0)}",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  portfolio.totalGain >= 0
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: portfolio.totalGain >= 0 ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  "${portfolio.totalGain >= 0 ? '+' : ''}₹${portfolio.totalGain.abs().toStringAsFixed(0)}",
                  style: TextStyle(
                    color: portfolio.totalGain >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
