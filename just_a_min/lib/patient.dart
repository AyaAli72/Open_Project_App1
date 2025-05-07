import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class patient_page extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<patient_page> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientEmailController = TextEditingController();
  final TextEditingController _patientPhoneController = TextEditingController();
  final TextEditingController _patientHistoryController =
      TextEditingController();

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientEmailController.dispose();
    _patientPhoneController.dispose();
    _patientHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: _patientNameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _patientEmailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _patientPhoneController,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 18,
                controller: _patientHistoryController,
                decoration: InputDecoration(
                  labelText: 'If you have a illness History Please enter it.',
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
