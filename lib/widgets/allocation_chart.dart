import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/portfolio_model.dart';

class AllocationChart extends StatelessWidget {
  final List<Holding> holdings;

  const AllocationChart({required this.holdings, super.key});

  @override
  Widget build(BuildContext context) {
    final total = holdings.fold(0.0, (sum, h) => sum + h.currentValue);
    if (total == 0) return SizedBox.shrink();

    final sections = holdings.map((h) {
      final percentage = (h.currentValue / total) * 100;
      return PieChartSectionData(
        value: h.currentValue,
        title: '${h.symbol}\n${percentage.toStringAsFixed(1)}%',
        color: Colors.primaries[holdings.indexOf(h) % Colors.primaries.length],
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Asset Allocation",
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
