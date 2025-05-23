import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetAPI.dart';
import 'main.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyPhoneController =
      TextEditingController();
  final TextEditingController _pharmacyEmailController =
      TextEditingController();
  final TextEditingController _pharmacyAddressController =
      TextEditingController();
  bool _isLoading = false;
  bool _addAnotherUser = false;

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _pharmacyPhoneController.dispose();
    _pharmacyEmailController.dispose();
    _pharmacyAddressController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _pharmacyNameController.clear();
    _pharmacyEmailController.clear();
    _pharmacyPhoneController.clear();
    _pharmacyAddressController.clear();
    _addAnotherUser = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _pharmacyNameController.text.trim();
    final email = _pharmacyEmailController.text.trim();
    final phone = _pharmacyPhoneController.text.trim();
    final address = _pharmacyAddressController.text.trim();

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
      const String sheetName = 'Pharmacy';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          name,
          phone,
          email,
          address,
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
    if (_pharmacyNameController.text.isEmpty &&
        _pharmacyEmailController.text.isEmpty &&
        _pharmacyPhoneController.text.isEmpty &&
        _pharmacyAddressController.text.isEmpty) {
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
              SizedBox(height: 20),
              TextField(
                controller: _pharmacyAddressController,
                decoration: InputDecoration(
                  labelText: 'Enter The Pharmacy Address',
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
              // TextField(
              //   maxLines: 20,
              //   controller: _pharmacyMediciensController,
              //   decoration: InputDecoration(
              //     labelText:
              //         'Enter Link Address For an Excel Sheet Have the Names of Your Mediciens, Price, Specification of the Medicien',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
