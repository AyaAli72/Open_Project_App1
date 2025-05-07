import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController _hospitalEmailController =
      TextEditingController();
  final TextEditingController _hospitalAddressController =
      TextEditingController();

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _hospitalPhoneController.dispose();
    _hospitalDoctorNamesController.dispose();
    _hospitalAmbulanceNumberController.dispose();
    _hospitalEmailController.dispose();
    _hospitalAddressController.dispose();
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
                maxLines: 100,
                controller: _hospitalNameController,
                decoration: InputDecoration(
                  labelText: 'Enter The Hospital name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 100,
                controller: _hospitalEmailController,
                decoration: InputDecoration(
                  labelText: 'Enter The Hospital Email',
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
                  keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _hospitalAmbulanceNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Ambulance Number.',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _hospitalAddressController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Hospital Address.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                controller: _hospitalDoctorNamesController,
                decoration: InputDecoration(
                  labelText:
                      'Enter A Linke for a Fiel Contain Hospital Doctors, Their Specification, and Price',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
