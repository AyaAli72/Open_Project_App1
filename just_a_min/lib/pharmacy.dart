import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pharmacy_page extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<Pharmacy_page> {
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyPhoneController =
      TextEditingController();
  final TextEditingController _pharmacyMediciensController =
      TextEditingController();
  final TextEditingController _pharmacyEmailController =
      TextEditingController();
  final TextEditingController _pharmacyAddressController =
      TextEditingController();

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _pharmacyPhoneController.dispose();
    _pharmacyMediciensController.dispose();
    _pharmacyEmailController.dispose();
    _pharmacyAddressController.dispose();
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
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _pharmacyEmailController,
                decoration: InputDecoration(
                  labelText: 'Enter The Pharmacy Email',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _pharmacyAddressController,
                decoration: InputDecoration(
                  labelText: 'Enter The Pharmacy Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 20,
                controller: _pharmacyMediciensController,
                decoration: InputDecoration(
                  labelText:
                      'Enter Link Address For an Excel Sheet Have the Names of Your Mediciens, Price, Specification of the Medicien',
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
