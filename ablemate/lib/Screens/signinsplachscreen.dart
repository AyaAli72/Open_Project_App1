import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ablemate/signinpage.dart';
import 'package:ablemate/main.dart';
class SignInSplashScreen extends StatefulWidget {
  const SignInSplashScreen({super.key});

  @override
  _SignInSplashScreenState createState() => _SignInSplashScreenState();
}

class _SignInSplashScreenState extends State<SignInSplashScreen> {
  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  SignInPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  MyHomePage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}