// lib/models/portfolio_model.dart
class UserPortfolio {
  final String username;
  final double portfolioValue;
  final double totalGain;
  final List<Holding> holdings;

  UserPortfolio({
    required this.username,
    required this.portfolioValue,
    required this.totalGain,
    required this.holdings,
  });

  factory UserPortfolio.fromJson(Map<String, dynamic> json) {
    var list = json['holdings'] as List? ?? [];
    List<Holding> holdings = list.map((i) => Holding.fromJson(i)).toList();

    return UserPortfolio(
      username: json['username'] ?? 'Unknown User',
      portfolioValue: (json['portfolio_value'] ?? 0).toDouble(),
      totalGain: (json['total_gain'] ?? 0).toDouble(),
      holdings: holdings,
    );
  }
}

class Holding {
  final String symbol;
  final String name;
  final int units;
  final double avgCost;
  final double currentPrice;

  Holding({
    required this.symbol,
    required this.name,
    required this.units,
    required this.avgCost,
    required this.currentPrice,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      symbol: json['symbol'] ?? 'N/A',
      name: json['name'] ?? 'Unknown',
      units: json['units'] ?? 0,
      avgCost: (json['avg_cost'] ?? 0).toDouble(),
      currentPrice: (json['current_price'] ?? 0).toDouble(),
    );
  }

  double get currentValue => units * currentPrice;
  double get investedValue => units * avgCost;
  double get gain => currentValue - investedValue;
  double get gainPercentage =>
      investedValue > 0 ? (gain / investedValue) * 100 : 0;
}
