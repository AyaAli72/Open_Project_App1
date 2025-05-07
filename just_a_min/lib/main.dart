import 'package:flutter/material.dart';
import 'patient.dart';
import 'doctor.dart';
import 'pharmacy.dart';
import 'hospital.dart';
import 'sidedrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/patient': (context) => patient_page(),
        '/doctor': (context) => Doctor_page(),
        '/hospital': (context) => Hospital_page(),
        '/pharmacy': (context) => Pharmacy_page(),
      },
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
        ),
      ),
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
                  text: "Patient",
                  icon: Icons.person,
                  page: patient_page(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Doctor",
                  icon: Icons.medical_services,
                  page: Doctor_page(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Hospital",
                  icon: Icons.local_hospital,
                  page: Hospital_page(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Pharmacy",
                  icon: Icons.local_pharmacy,
                  page: Pharmacy_page(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
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
}
