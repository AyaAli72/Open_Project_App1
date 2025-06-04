import 'package:flutter/material.dart';
import 'patient.dart';
import 'doctor.dart';
import 'pharmacy.dart';
import 'hospital.dart';

class MyDrawer_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sign-in options
          _buildDrawerItem(
            context: context,
            text: "Patient",
            icon: Icons.person,
            page: PatientPage(),
          ),
          _buildDrawerItem(
            context: context,
            text: "Doctor",
            icon: Icons.medical_services,
            page: DoctorPage(),
          ),
          _buildDrawerItem(
            context: context,
            text: "Hospital",
            icon: Icons.local_hospital,
            page: HospitalPage(),
          ),
          _buildDrawerItem(
            context: context,
            text: "Pharmacy",
            icon: Icons.local_pharmacy,
            page: PharmacyPage(),
          ),
          Divider(),
          // Additional drawer items
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle settings navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.blue),
            title: Text('Help & Support', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle help navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue),
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.medical_services, size: 100, color: Colors.blue),
              SizedBox(height: 30),
              Text(
                "Welcome to JUST 1 MINUTE",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Open the side menu to access healthcare services",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  "Open Menu",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
