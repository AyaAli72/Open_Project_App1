import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetAPI.dart';
import 'main.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
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
    final workplace = _doctorWorkplaceController_.text.trim();
    final specialization = _doctorSpecializationController_.text.trim();
    final certificate = _doctorCertificateController_.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        workplace.isEmpty ||
        specialization.isEmpty ||
        certificate.isEmpty) {
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
          specialization,
          certificate,
          workplace,
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
    if (_doctornameController_.text.isEmpty &&
        _doctoremailController_.text.isEmpty &&
        _doctorphoneController_.text.isEmpty &&
        _doctorWorkplaceController_.text.isEmpty &&
        _doctorSpecializationController_.text.isEmpty &&
        _doctorCertificateController_.text.isEmpty) {
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
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctoremailController_,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorphoneController_,
                decoration: InputDecoration(
                  labelText: 'Enter your Phone Number',
                  prefixIcon: Icon(Icons.phone),
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
                  prefixIcon: Icon(Icons.details),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 20,
                controller: _doctorCertificateController_,
                decoration: InputDecoration(
                  labelText: 'Enter your certificates.',
                  prefixIcon: Icon(Icons.details),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorWorkplaceController_,
                decoration: InputDecoration(
                  labelText: 'Enter your WorkPlace (Clinic/ Hospital) Address.',
                  prefixIcon: Icon(Icons.location_on),
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
