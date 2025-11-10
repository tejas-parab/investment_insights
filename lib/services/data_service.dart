// lib/services/data_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../models/portfolio_model.dart';

class DataService {
  static List<UserPortfolio> _users = [];

  static Future<void> _loadUsers() async {
    if (_users.isNotEmpty) return;
    try {
      final String data = await rootBundle.loadString('assets/portfolio.json');
      final Map<String, dynamic> json = jsonDecode(data);
      final List<dynamic> userList = json['users'] ?? [];
      _users = userList.map((u) => UserPortfolio.fromJson(u)).toList();
    } catch (e) {
      _users = [];
    }
  }

  static Future<UserPortfolio?> getUserByUsername(String username) async {
    await _loadUsers();
    try {
      return _users.firstWhere(
        (user) => user.username.toLowerCase() == username.trim().toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // THIS WAS MISSING — NOW ADDED
  static Future<List<String>> getAllUsernames() async {
    await _loadUsers();
    return _users.map((u) => u.username).toList();
  }

  static Future<UserPortfolio> loadPortfolio(String username) async {
    final user = await getUserByUsername(username);
    if (user == null) throw Exception("User not found: $username");
    return user;
  }

  static Future<UserPortfolio> refreshPortfolio(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = await getUserByUsername(username);
    if (user == null) throw Exception("User not found");

    final random = Random();
    final updated = user.holdings.map((h) {
      final change = (random.nextDouble() - 0.5) * 0.1; // ±5%
      final newPrice = h.currentPrice * (1 + change);
      return Holding(
        symbol: h.symbol,
        name: h.name,
        units: h.units,
        avgCost: h.avgCost,
        currentPrice: double.parse(newPrice.toStringAsFixed(2)),
      );
    }).toList();

    final newValue = updated.fold(0.0, (s, h) => s + h.currentValue);
    final newGain = updated.fold(0.0, (s, h) => s + h.gain);

    return UserPortfolio(
      username: user.username,
      portfolioValue: newValue,
      totalGain: newGain,
      holdings: updated,
    );
  }
}
