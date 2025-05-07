import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Doctor_page extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<Doctor_page> {
  final TextEditingController _doctornameController_ = TextEditingController();
  final TextEditingController _doctoremailController_ = TextEditingController();
  final TextEditingController _doctorphoneController_ = TextEditingController();
  final TextEditingController _doctorSpecializationController_ =
      TextEditingController();
  final TextEditingController _doctorCertificateController_ =
      TextEditingController();
  @override
  void dispose() {
    _doctornameController_.dispose();
    _doctoremailController_.dispose();
    _doctorphoneController_.dispose();
    _doctorSpecializationController_.dispose();
    _doctorCertificateController_.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _doctornameController_,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctoremailController_,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorphoneController_,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorSpecializationController_,
                decoration: InputDecoration(
                  labelText: 'Enter Your Specialization.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 15,
                controller: _doctorCertificateController_,
                decoration: InputDecoration(
                  labelText: 'Enter your certificates.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 15,
                controller: _doctorCertificateController_,
                decoration: InputDecoration(
                  labelText: 'Enter your WorkPlace (Clinic/ Hospital) Address.',
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
