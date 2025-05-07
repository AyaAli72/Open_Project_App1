import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetAPI.dart';

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
  final TextEditingController _doctorWorkplaceController_ =
      TextEditingController();
  bool _isLoading = false;
  bool _addAnotherUser = false;

  @override
  void dispose() {
    _doctornameController_.dispose();
    _doctoremailController_.dispose();
    _doctorphoneController_.dispose();
    _doctorSpecializationController_.dispose();
    _doctorCertificateController_.dispose();
    _doctorWorkplaceController_.dispose();
    super.dispose();
  }

  void _resetForm() {
    _doctornameController_.clear();
    _doctoremailController_.clear();
    _doctorphoneController_.clear();
    _doctorWorkplaceController_.clear();
    _doctorSpecializationController_.clear();
    _doctorCertificateController_.clear();
    _addAnotherUser = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final name = _doctornameController_.text.trim();
    final email = _doctoremailController_.text.trim();
    final phone = _doctorphoneController_.text.trim();
    final address = _doctorWorkplaceController_.text.trim();
    final specification = _doctorSpecializationController_.text.trim();
    final certificate = _doctorCertificateController_.text.trim();

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
      const String sheetName = 'Doctor';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          name,
          phone,
          email,
          specification,
          certificate,
          address,
          DateTime.now().toString(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User data saved successfully!")),
      );

      if (_addAnotherUser) {
        _resetForm();
      } else {}
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
                maxLines: 20,
                controller: _doctorSpecializationController_,
                decoration: InputDecoration(
                  labelText: 'Enter Your Specialization.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 20,
                controller: _doctorCertificateController_,
                decoration: InputDecoration(
                  labelText: 'Enter your certificates.',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorWorkplaceController_,
                decoration: InputDecoration(
                  labelText: 'Enter your WorkPlace (Clinic/ Hospital) Address.',
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
