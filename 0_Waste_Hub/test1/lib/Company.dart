import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final TextEditingController _companyPageNameController =
      TextEditingController();
  final TextEditingController _companyPhoneController = TextEditingController();
  final TextEditingController _companyemailController = TextEditingController();
  final TextEditingController _companyMaterialController =
      TextEditingController();
  final TextEditingController _companyMaterialAmountController =
      TextEditingController();

  @override
  void dispose() {
    _companyPageNameController.dispose();
    _companyPhoneController.dispose();
    _companyemailController.dispose();
    _companyMaterialController.dispose();
    _companyMaterialAmountController.dispose();
    super.dispose(); // Don't forget this!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Company Page",
            style: TextStyle(
                color: Colors.green, fontSize:30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 230, 224, 224)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _companyPageNameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyemailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyPhoneController,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 10,
                controller: _companyMaterialController,
                decoration: InputDecoration(
                  labelText: 'Enter the Materil you Want to check.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyMaterialAmountController,
                decoration: InputDecoration(
                  labelText: 'Enter the amount Materil you Want to check.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 60,
                width: 60,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.green),
                onPressed: () {},
                child: Text(
                  "Submite",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
