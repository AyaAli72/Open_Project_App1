import 'package:flutter/material.dart';
import 'googlesheetapi.dart';

class AddMaterialPage extends StatefulWidget {
  @override
  _AddMaterialPageState createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final TextEditingController _materialDetailsController =
      TextEditingController();
  final TextEditingController _materialAmountController =
      TextEditingController();
  final TextEditingController _materialPriceController =
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
    _materialDetailsController.dispose();
    _materialAmountController.dispose();
    _materialPriceController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _materialDetailsController.clear();
    _materialAmountController.clear();
    _materialPriceController.clear();
    _addAnotherMaterial = false;
  }

  Future<void> _submitData() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final materialDetails = _materialDetailsController.text.trim();
    final materialAmount = _materialAmountController.text.trim();
    final materialPrice = _materialPriceController.text.trim();

    if (materialDetails.isEmpty ||
        materialAmount.isEmpty ||
        materialPrice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      const String spreadsheetId =
          '1N2gYaGOuN-VdU4EznQrx0jkCkbKJ9QZ2JZphSVDGHVA';
      const String sheetName =
          'Material'; 

      await GoogleSheetsApi.appendRow(
        spreadsheetId: spreadsheetId,
        sheetName: sheetName,
        rowData: [
          materialDetails,
          materialAmount,
          materialPrice,
          DateTime.now().toString(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Material data saved successfully!")),
      );

      if (_addAnotherMaterial) {
        _resetForm();
      } else {
        Navigator.pop(context); // Go back to previous page after submission
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
    if (_materialDetailsController.text.isEmpty &&
        _materialAmountController.text.isEmpty &&
        _materialPriceController.text.isEmpty) {
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
            "Add Material",
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
                controller: _materialDetailsController,
                decoration: InputDecoration(
                  labelText: 'Material Details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _materialAmountController,
                decoration: InputDecoration(
                  labelText: 'Material Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _materialPriceController,
                decoration: InputDecoration(
                  labelText: 'Material Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        "Add Material",
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
