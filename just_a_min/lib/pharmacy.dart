import 'package:flutter/material.dart';

class Pharmacy_page extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<Pharmacy_page> {
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyPhoneController =
      TextEditingController();
  final TextEditingController _patientMediciensController =
      TextEditingController();

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _pharmacyPhoneController.dispose();
    _patientMediciensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pharmacy Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _pharmacyNameController,
                decoration: InputDecoration(
                  labelText: 'Enter The Pharmacy Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _pharmacyPhoneController,
                decoration: InputDecoration(
                  labelText: 'Enter The Pharmacy Phone Numbers',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 20,
                controller: _patientMediciensController,
                decoration: InputDecoration(
                  labelText:
                      'Enter The Names of the Medicines you have in Your Pharmacy',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
