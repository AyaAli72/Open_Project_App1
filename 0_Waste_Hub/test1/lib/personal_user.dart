import 'package:flutter/material.dart';
import 'googlesheetapi.dart';
import 'main.dart';

class PersonalUserPage extends StatefulWidget {
  @override
  _PersonalUserPageState createState() => _PersonalUserPageState();
}

class _PersonalUserPageState extends State<PersonalUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;
  bool _addAnotherUser = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _addAnotherUser = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      const String spreadsheetId =
          '1N2gYaGOuN-VdU4EznQrx0jkCkbKJ9QZ2JZphSVDGHVA';
      const String sheetName = 'PersonalUser';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          name,
          email,
          phone,
          address,
          DateTime.now().toString(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User data saved successfully!")),
      );

      if (_addAnotherUser) {
        _resetForm();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save data: ${e.toString()}")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _confirmBackNavigation() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("Leaving will clear any unsaved information."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _resetForm();
              Navigator.pop(context, true);
            },
            child: Text("Leave"),
          ),
        ],
      ),
    );
    return shouldLeave ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add User Information",
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 235, 225, 225),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Full Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.green,
                ),
                onPressed: _isLoading ? null : _submitData,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        _addAnotherUser ? "Save & Add Another" : "Submit",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
