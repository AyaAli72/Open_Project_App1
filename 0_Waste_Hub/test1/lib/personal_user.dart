import 'package:flutter/material.dart';

class PersonalUserPage extends StatefulWidget {
  @override
  _PersonalUserPageState createState() => _PersonalUserPageState();
}

class _PersonalUserPageState extends State<PersonalUserPage> {
  final TextEditingController _personalUserNameController =
      TextEditingController();
  final TextEditingController _personalUserPhoneController =
      TextEditingController();
  final TextEditingController _personalUseremailController =
      TextEditingController();
  final TextEditingController _personalUserMaterialController =
      TextEditingController();
  final TextEditingController _personalUserMaterialAmountController =
      TextEditingController();

  @override
  void dispose() {
    _personalUserNameController.dispose();
    _personalUserPhoneController.dispose();
    _personalUseremailController.dispose();
    _personalUserMaterialController.dispose();
    _personalUserMaterialAmountController.dispose();
    super.dispose(); // Don't forget this!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal User Page",
          style: TextStyle(
              color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 225, 225),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _personalUserNameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _personalUseremailController,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _personalUserPhoneController,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _personalUserMaterialController,
                decoration: InputDecoration(
                  labelText: 'Enter the Materil you Want to check.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _personalUserMaterialAmountController,
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
