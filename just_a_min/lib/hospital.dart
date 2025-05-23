import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetAPI.dart';
import 'main.dart';

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  final TextEditingController _hospitalNameController = TextEditingController();
  // final TextEditingController _hospitalDoctorNamesController =
  // TextEditingController();
  final TextEditingController _hospitalPhoneController =
      TextEditingController();
  final TextEditingController _hospitalAmbulanceNumberController =
      TextEditingController();
  final TextEditingController _hospitalEmailController =
      TextEditingController();
  final TextEditingController _hospitalAddressController =
      TextEditingController();
  bool _isLoading = false;
  bool _addAnotherUser = false;

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _hospitalPhoneController.dispose();
    _hospitalAmbulanceNumberController.dispose();
    _hospitalEmailController.dispose();
    _hospitalAddressController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _hospitalNameController.clear();
    _hospitalEmailController.clear();
    _hospitalPhoneController.clear();
    _hospitalAddressController.clear();
    _hospitalAmbulanceNumberController.clear();

    _addAnotherUser = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _hospitalNameController.text.trim();
    final email = _hospitalEmailController.text.trim();
    final phone = _hospitalPhoneController.text.trim();
    final address = _hospitalAddressController.text.trim();
    final ambnumber = _hospitalAmbulanceNumberController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      const String spreadsheetId =
          '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M';
      const String sheetName = 'Hospital';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          name,
          phone,
          email,
          address,
          ambnumber,
          DateTime.now().toString(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Company data saved successfully!")),
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
    if (_hospitalNameController.text.isEmpty &&
        _hospitalEmailController.text.isEmpty &&
        _hospitalPhoneController.text.isEmpty &&
        _hospitalAddressController.text.isEmpty &&
        _hospitalAmbulanceNumberController.text.isEmpty) {
      return true;
    }

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("Unsaved changes will be lost."),
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
                controller: _hospitalEmailController,
                decoration: InputDecoration(
                  labelText: 'Enter The Hospital Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color.fromARGB(255, 31, 146, 222),
                ),
                onPressed: _isLoading ? null : _submitData,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Submit",
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
