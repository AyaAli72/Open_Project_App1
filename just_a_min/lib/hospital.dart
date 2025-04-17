import 'package:flutter/material.dart';

class Hospital_page extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<Hospital_page> {
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _hospitalDoctorNamesController =
      TextEditingController();
  final TextEditingController _hospitalPhoneController =
      TextEditingController();
  final TextEditingController _hospitalAmbulanceNumberController =
      TextEditingController();

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _hospitalPhoneController.dispose();
    _hospitalDoctorNamesController.dispose();
    _hospitalAmbulanceNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _hospitalNameController,
                decoration: InputDecoration(
                  labelText: 'Enter The Hospital name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _hospitalPhoneController,
                decoration: InputDecoration(
                  labelText: 'Enter The hospital Phone Numbers',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                controller: _hospitalDoctorNamesController,
                decoration: InputDecoration(
                  labelText:
                      'Enter The Names of the Doctors you have and their Specialization',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _hospitalAmbulanceNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Ambulance Number.',
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
