import 'package:flutter/material.dart';
import 'package:just_a_min/screens/splashscreen.dart';
import 'sidedrawer_options/doctortap.dart';
import 'sidedrawer_options/hospitaltap.dart';
import 'sidedrawer_options/pharmacytap.dart';
import 'sidedrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Just a minute.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),),
        drawer: MyDrawer_Page(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Doctor",
                  icon: Icons.medical_services,
                  page: DoctorTap_Page(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Hospital",
                  icon: Icons.local_hospital,
                  page: HospitalTap_Page(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Pharmacy",
                  icon: Icons.local_pharmacy,
                  page: PharmacyTap_Page(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Widget _buildNavigationButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Widget page,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
        ),
        icon: Icon(icon, size: 30, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
