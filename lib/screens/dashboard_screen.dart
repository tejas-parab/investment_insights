// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/portfolio_model.dart';
import '../services/data_service.dart';
import '../widgets/header_widget.dart';
import '../widgets/holdings_card.dart';
import '../widgets/allocation_chart.dart';
import '../widgets/sort_dropdown.dart';
import '../widgets/return_toggle.dart';
import 'login_screen.dart';
import '../utils/theme.dart';

enum SortBy { name, value, gain }

enum ViewMode { amount, percentage }

class DashboardScreen extends StatefulWidget {
  final String username;
  const DashboardScreen({required this.username, super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<UserPortfolio> portfolioFuture;
  SortBy sortBy = SortBy.value;
  ViewMode viewMode = ViewMode.amount;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    portfolioFuture = DataService.loadPortfolio(widget.username);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void _refresh() {
    setState(() {
      portfolioFuture = DataService.refreshPortfolio(widget.username);
    });
  }

  void _toggleDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = !isDarkMode;
    await prefs.setBool('darkMode', newMode);
    setState(() => isDarkMode = newMode);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Only remove username, keep dark mode
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? AppTheme.dark : AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FinView Lite"),
          actions: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
            IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async => _refresh(),
          child: FutureBuilder<UserPortfolio>(
            future: portfolioFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final portfolio = snapshot.data!;
              final holdings = List<Holding>.from(portfolio.holdings);

              if (holdings.isEmpty) {
                return _buildEmptyState();
              }

              holdings.sort((a, b) {
                switch (sortBy) {
                  case SortBy.name:
                    return a.name.compareTo(b.name);
                  case SortBy.value:
                    return b.currentValue.compareTo(a.currentValue);
                  case SortBy.gain:
                    return b.gain.compareTo(a.gain);
                }
              });

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  HeaderWidget(portfolio: portfolio, username: widget.username),
                  const SizedBox(height: 20),
                  AllocationChart(holdings: holdings),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SortDropdown(
                          value: sortBy,
                          onChanged: (val) => setState(() => sortBy = val!)),
                      ReturnToggle(
                          viewMode: viewMode,
                          onChanged: (mode) => setState(() => viewMode = mode)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...holdings
                      .map((h) => HoldingsCard(holding: h, viewMode: viewMode)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text("No investments yet", style: TextStyle(fontSize: 24)),
            Text("Your portfolio is empty",
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
