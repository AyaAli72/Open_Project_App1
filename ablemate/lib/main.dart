import 'package:flutter/material.dart';
import 'ASD.dart';
import 'Downsyndrome.dart';
import 'blind.dart';
import 'deaf.dart';
import 'Screens/splashscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AbleMate App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AbleMate Main Page',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildInteractiveContainer(context,
                        height: 200, text: 'Blind', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BlindPage()),
                      );
                    }),
                    const SizedBox(height: 20),
                    _buildInteractiveContainer(context,
                        height: 200, text: 'Deaf', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeafPage()),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _buildInteractiveContainer(context,
                        height: 200, text: 'Down Syndrome', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DownPage()),
                      );
                    }),
                    const SizedBox(height: 20),
                    _buildInteractiveContainer(
                      context,
                      height: 200,
                      text: 'Autism Spectrum Disorder (ASD)',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ASDPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractiveContainer(
    BuildContext context, {
    required double height,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.white.withOpacity(0.3),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
