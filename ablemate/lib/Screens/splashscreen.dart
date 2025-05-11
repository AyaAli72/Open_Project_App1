import 'package:flutter/material.dart';
import 'package:ablemate/main.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  static const String splashImagePath = 'assets/images/image1.jpg';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initializeApp().then((_) => _navigateToHome(context));

    return Scaffold(
      body: _buildFullScreenSplashContent(context),
    );
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  void _navigateToHome(BuildContext context) {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MyHomePage(title: 'AbleMate'),
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      _showErrorRetryDialog(context);
    }
  }

  Widget _buildFullScreenSplashContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // This makes the Stack fill the entire screen
      children: [
        // Full-screen background image
        Image.asset(
          splashImagePath,
          fit: BoxFit.cover, // Cover the entire screen
          width: 1500,
          height: 1500,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.blue, // Fallback color if image fails to load
            child: const Center(child: FlutterLogo(size: 100)),
          ),
        ),
        // Loading indicator overlay
        const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorRetryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to load app. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToHome(context);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
