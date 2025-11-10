// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/data_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  List<String> _validUsers = [];

  @override
  void initState() {
    super.initState();
    _loadValidUsers();
  }

  Future<void> _loadValidUsers() async {
    final users = await DataService.getAllUsernames();
    setState(() => _validUsers = users);
  }

  Future<void> _login() async {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter username")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final user = await DataService.getUserByUsername(input);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Invalid user! Try: ${_validUsers.join(', ')}"),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (_) => DashboardScreen(username: user.username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  const Icon(Icons.insights_rounded,
                      size: 100, color: Colors.white),
                  const SizedBox(height: 24),
                  const Text("FinView Lite",
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const Text("Investment Insights Dashboard",
                      style: TextStyle(fontSize: 18, color: Colors.white70)),
                  const SizedBox(height: 60),
                  const Text("Authorized Users Only",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter username (e.g. Aarav Patel)",
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF667eea),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Color(0xFF667eea))
                          : const Text("Login",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_validUsers.isNotEmpty)
                    Text(
                      "Valid users: ${_validUsers.join(' • ')}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
