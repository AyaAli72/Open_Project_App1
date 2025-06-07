import 'package:flutter/material.dart';
import 'main.dart';
import 'googlesheetapi.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final TextEditingController _companyPageNameController =
      TextEditingController();
  final TextEditingController _companyPhoneController = TextEditingController();
  final TextEditingController _companyemailController = TextEditingController();
  final TextEditingController _companyaddressController =
      TextEditingController();
  bool _isLoading = false;
  bool _addAnotherUser = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.addScopedWillPopCallback(() async {
        return await _confirmBackNavigation();
      });
    });
  }

  @override
  void dispose() {
    _companyPageNameController.dispose();
    _companyPhoneController.dispose();
    _companyemailController.dispose();
    _companyaddressController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _companyPageNameController.clear();
    _companyPhoneController.clear();
    _companyemailController.clear();
    _companyaddressController.clear();
    _addAnotherUser = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _companyPageNameController.text.trim();
    final email = _companyemailController.text.trim();
    final phone = _companyPhoneController.text.trim();
    final address = _companyaddressController.text.trim();

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
      const String sheetName = 'Company';

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
    if (_companyPageNameController.text.isEmpty &&
        _companyemailController.text.isEmpty &&
        _companyPhoneController.text.isEmpty &&
        _companyaddressController.text.isEmpty) {
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
    return WillPopScope(
      onWillPop: _confirmBackNavigation,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Company Information",
            style: TextStyle(
              color: Colors.green,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: _companyPageNameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyemailController,
                decoration: InputDecoration(
                  labelText: 'Company Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyPhoneController,
                decoration: InputDecoration(
                  labelText: 'Company Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _companyaddressController,
                decoration: InputDecoration(
                  labelText: 'Company Address',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.green,
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
