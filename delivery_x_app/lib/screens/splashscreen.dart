import 'package:delivery_x_app/main.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToHome(context);
    });

    return Scaffold(
      body: _buildSplashContent(),
    );
  }

  void _navigateToHome(BuildContext context) {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(),
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback: Show error and retry button
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load app')),
      );
    }
  }

  Widget _buildSplashContent() {
    try {
      return Center(
        child: Image.asset(
          'assets/images/image1.jpg',
          errorBuilder: (_, __, ___) => const Placeholder(), // Fallback widget
        ),
      );
    } catch (e) {
      debugPrint('Image load error: $e');
      return const Center(child: Text('App Logo'));
    }
  }
}
