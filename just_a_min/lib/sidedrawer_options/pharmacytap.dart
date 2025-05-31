import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart'; // Your Google Sheets API class

class PharmacyTap_Page extends StatefulWidget {
  @override
  _PharmacyTap_PageState createState() => _PharmacyTap_PageState();
}

class _PharmacyTap_PageState extends State<PharmacyTap_Page> {
  // Medicine data organized by category
  List<MedicineItem> _medicinesCategory1 = [];
  List<MedicineItem> _medicinesCategory2 = [];
  List<MedicineItem> _medicinesCategory3 = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      // Fetch data from Google Sheets
      final data = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Pharmacy!A:E', // Adjust to your sheet range
      );

      // Process raw data into medicine items
      final allMedicines = _parseSheetData(data);

      // Categorize medicines (modify this logic based on your data structure)
      setState(() {
        _medicinesCategory1 =
            allMedicines.where((item) => item.category == 1).toList();
        _medicinesCategory2 =
            allMedicines.where((item) => item.category == 2).toList();
        _medicinesCategory3 =
            allMedicines.where((item) => item.category == 3).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<MedicineItem> _parseSheetData(List<List<String>> data) {
    // Skip header row if exists
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Map columns to medicine properties (adjust indices based on your sheet structure)
      return MedicineItem(
        category: int.tryParse(row[0]) ?? 1, // First column = category
        pharmacyName: row[1], // Second column = pharmacy name
        medicineName: row[2], // Third column = medicine name
        pharmacyPhone: row[3], // Fourth column = phone
        price: double.tryParse(row[4]) ?? 0.0, // Fifth column = price
      );
    }).toList();
  }

  Widget _buildMedicineList(String title, List<MedicineItem> medicines) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 200,
          child: medicines.isEmpty
              ? Center(child: Text('No medicines available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: Container(
                        width: 160,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              medicine.pharmacyName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              medicine.medicineName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              medicine.pharmacyPhone,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Price: \$${medicine.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pharmacy",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        _buildMedicineList('Medicien', _medicinesCategory1),
                        SizedBox(height: 12),
                        _buildMedicineList('Medicens', _medicinesCategory2),
                        SizedBox(height: 12),
                        _buildMedicineList('Mediciens', _medicinesCategory3),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class MedicineItem {
  final int category;
  final String pharmacyName;
  final String medicineName;
  final String pharmacyPhone;
  final double price;

  MedicineItem({
    required this.category,
    required this.pharmacyName,
    required this.medicineName,
    required this.pharmacyPhone,
    required this.price,
  });
}


