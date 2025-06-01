import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetapi.dart';

class AddMedecienPage extends StatefulWidget {
  @override
  _AddMedecienPageState createState() => _AddMedecienPageState();
}

class _AddMedecienPageState extends State<AddMedecienPage> {
  final TextEditingController _medeciensNameController =
      TextEditingController();
  final TextEditingController _medeciendetailController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyPhoneController =
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
    _medeciensNameController.dispose();
    _medeciendetailController.dispose();
    _priceController.dispose();
    _pharmacyNameController.dispose();
    _pharmacyPhoneController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _medeciensNameController.clear();
    _medeciendetailController.clear();
    _priceController.clear();
    _pharmacyNameController.clear();
    _pharmacyPhoneController.clear();
    _addAnotherMaterial = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final medecienname = _medeciensNameController.text.trim();
    final medeciendetail = _medeciendetailController.text.trim();
    final medecienPrice = _priceController.text.trim();
    final pharmacyname = _pharmacyNameController.text.trim();
    final pharmacyphone = _pharmacyPhoneController.text.trim();

    if (medecienname.isEmpty ||
        medeciendetail.isEmpty ||
        medecienPrice.isEmpty ||
        pharmacyname.isEmpty ||
        pharmacyphone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      String spreadsheetId = '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M';
      String sheetName = 'Mediciens';

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          medecienname,
          medeciendetail,
          medecienPrice,
          pharmacyname,
          pharmacyphone,
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
    if (_medeciensNameController.text.isEmpty &&
        _medeciendetailController.text.isEmpty &&
        _priceController.text.isEmpty &&
        _pharmacyNameController.text.isEmpty &&
        _pharmacyPhoneController.text.isEmpty) {
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
            "Add Medeciens",
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
                controller: _medeciensNameController,
                decoration: InputDecoration(
                  labelText: 'Medecien Name',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _medeciendetailController,
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
                  labelText: 'Medicien Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pharmacyNameController,
                decoration: InputDecoration(
                  labelText: 'Pharmacy Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pharmacyPhoneController,
                decoration: InputDecoration(
                  labelText: 'Pharmacy Phone',
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
                        "Add Medeciens",
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
