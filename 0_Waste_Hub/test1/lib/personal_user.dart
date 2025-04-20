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
      appBar: AppBar(title: Text("Personal User Page")),
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
            ],
          ),
        ),
      ),
    );
  }
}
