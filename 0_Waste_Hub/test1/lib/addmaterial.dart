import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'googlesheetapi.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

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
      const String sheetName = 'Material';

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

  // In _pickImage, remove the incorrect _uploadImage call
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        // Optionally auto-upload:
        await _uploadImage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return;
    }

    // Here you would implement your upload logic
    // For example, uploading to Firebase Storage, your own server, etc.
    // This is just a placeholder for the upload process
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Uploading image...')),
    );

    // Simulate upload delay
    await Future.delayed(Duration(seconds: 2));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded successfully!')),
    );
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
          backgroundColor: Color.fromARGB(255, 30, 29, 29),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _materialDetailsController,
                decoration: InputDecoration(
                  labelText: 'Material Details',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _materialAmountController,
                decoration: InputDecoration(
                  labelText: 'Material Amount',
                  prefixIcon: Icon(Icons.scale),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _materialPriceController,
                decoration: InputDecoration(
                  labelText: 'Material Price',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _materialPriceController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _materialPriceController,
                decoration: InputDecoration(
                  labelText: 'User Address',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _materialPriceController,
                decoration: InputDecoration(
                  labelText: 'User Phone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: const Text(
                      'Take Photo',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: const Text(
                      'Choose from Gallery',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (_imageFile != null) ...[
                SizedBox(height: 10),
                Image.file(_imageFile!, height: 100),
                SizedBox(height: 10),
              ],
              const SizedBox(
                height: 10,
              ),
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
