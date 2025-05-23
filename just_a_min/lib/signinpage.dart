import 'package:flutter/material.dart';
import 'patient.dart';
import 'doctor.dart';
import 'pharmacy.dart';
import 'hospital.dart';
import 'sidedrawer.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JUST 1 MINUTE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Patient",
                  icon: Icons.person,
                  page: PatientPage(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Doctor",
                  icon: Icons.medical_services,
                  page: DoctorPage(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Hospital",
                  icon: Icons.local_hospital,
                  page: HospitalPage(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButton(
                  context: context,
                  text: "Pharmacy",
                  icon: Icons.local_pharmacy,
                  page: PharmacyPage(),
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
