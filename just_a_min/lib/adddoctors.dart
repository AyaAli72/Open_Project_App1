import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetapi.dart';

class AddDoctorsPage extends StatefulWidget {
  @override
  _AddDoctorsPageState createState() => _AddDoctorsPageState();
}

class _AddDoctorsPageState extends State<AddDoctorsPage> {
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _doctorSpecificationController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _hospitalPhoneController =
      TextEditingController();
  bool _isLoading = false;
  bool _addAnotherMaterial = false;

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
    _doctorNameController.dispose();
    _doctorSpecificationController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    _hospitalNameController.dispose();
    _hospitalPhoneController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _doctorNameController.clear();
    _doctorSpecificationController.clear();
    _priceController.clear();
    _dateController.clear();
    _hospitalNameController.clear();
    _hospitalPhoneController.clear();
    _addAnotherMaterial = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final doctorname = _doctorNameController.text.trim();
    final doctorspecification = _doctorSpecificationController.text.trim();
    final doctorPrice = _priceController.text.trim();
    final doctordate = _dateController.text.trim();
    final doctorhospital = _hospitalNameController.text.trim();
    final hospitalphone = _hospitalPhoneController.text.trim();

    if (doctorname.isEmpty ||
        doctorspecification.isEmpty ||
        doctorPrice.isEmpty ||
        doctordate.isEmpty ||
        doctorhospital.isEmpty ||
        hospitalphone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      String spreadsheetId = '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M';
      String sheetName = 'Hospitaldoctor';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          doctorname,
          doctorspecification,
          doctorPrice,
          doctordate,
          doctorhospital,
          hospitalphone,
          DateTime.now().toString(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Doctor data saved successfully!")),
      );

      if (_addAnotherMaterial) {
        _resetForm();
      } else {
        Navigator.pop(context);
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
    if (_doctorNameController.text.isEmpty &&
        _doctorSpecificationController.text.isEmpty &&
        _priceController.text.isEmpty &&
        _dateController.text.isEmpty &&
        _hospitalNameController.text.isEmpty &&
        _hospitalPhoneController.text.isEmpty) {
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
            "Add Doctors",
            style: TextStyle(
              color: Color.fromARGB(255, 236, 238, 240),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 34, 140, 206),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _doctorNameController,
                decoration: InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _doctorSpecificationController,
                decoration: InputDecoration(
                  labelText: 'Doctor Specification',
                  border: OutlineInputBorder(),
                ),
                // keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Doctor Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Doctor Date',
                  border: OutlineInputBorder(),
                ),
                // keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _hospitalNameController,
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _hospitalPhoneController,
                decoration: InputDecoration(
                  labelText: 'Hospital Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color.fromARGB(255, 71, 135, 218),
                ),
                onPressed: _isLoading ? null : _submitData,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Add Doctor",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
