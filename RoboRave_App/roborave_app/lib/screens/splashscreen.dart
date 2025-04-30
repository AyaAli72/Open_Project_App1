import 'package:flutter/material.dart';
import 'package:roborave_app/main.dart'; // MyHomePage should be in a separate file

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      _navigateToHome(context);
    });

    return Scaffold(
      body: _buildSplashContent(context),
    );
  }

  void _navigateToHome(BuildContext context) {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MyHomePage(title: 'RoboRave Egypt'),
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

  Widget _buildSplashContent(BuildContext context) {
    try {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height, // Full height of the screen
        color: Color.fromARGB(255, 70, 62, 62),
        child: Image.asset(
          'assets/images/image2.png',
          fit: BoxFit.contain, // Show full image without cropping
          errorBuilder: (_, __, ___) => const Placeholder(),
        ),
      );
    } catch (e) {
      debugPrint('Image load error: $e');
      return const Center(child: Text('App Logo'));
    }
  }
}
