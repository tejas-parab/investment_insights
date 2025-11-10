import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedUser = prefs.getString('username');
  final isDark = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(initialUser: savedUser, isDarkMode: isDark));
}

class MyApp extends StatelessWidget {
  final String? initialUser;
  final bool isDarkMode;

  const MyApp({this.initialUser, required this.isDarkMode, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinView Lite',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: initialUser != null
          ? DashboardScreen(username: initialUser!)
          : LoginScreen(),
    );
  }
}
