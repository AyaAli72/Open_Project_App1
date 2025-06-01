import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart';

class PharmacyTap_Page extends StatefulWidget {
  @override
  _PharmacyTap_PageState createState() => _PharmacyTap_PageState();
}

class _PharmacyTap_PageState extends State<PharmacyTap_Page> {
  // Medicine data organized by category
  List<MedicineItem> _medicinesCategory1 = [];
  // List<MedicineItem> _medicinesCategory2 = [];
  List<MedicineItem> _medicinesCategory3 = [];

  // New list for medical equipment
  List<MedicalEquipmentItem> _equipmentList = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      // Fetch pharmacy data
      final pharmacyData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Pharmacy!A:D',
      );
      final allMedicines = _parsePharmacySheetData(pharmacyData);

      // Fetch medical equipment data from another sheet
      final equipmentData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Mediciens', // Adjust range to match your sheet
      );
      final equipment = _parseEquipmentSheetData(equipmentData);

      setState(() {
        _medicinesCategory1 =
            allMedicines.where((item) => item.category == 1).toList();
        // _medicinesCategory2 =
        //     allMedicines.where((item) => item.category == 2).toList();
        _medicinesCategory3 =
            allMedicines.where((item) => item.category == 3).toList();
        _equipmentList = equipment;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<MedicineItem> _parsePharmacySheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      return MedicineItem(
        category: int.tryParse(row[0]) ?? 1,
        pharmacyName: row[0],
        medicineName: row[1],
        pharmacyPhone: row[2],
        price: double.tryParse(row[3]) ?? 0.0,
      );
    }).toList();
  }

  List<MedicalEquipmentItem> _parseEquipmentSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      return MedicalEquipmentItem(
        equipmentName: row[0],
        description: row[1],
        price: double.tryParse(row[2]) ?? 0.0,
        contactPhone: row[3],
      );
    }).toList();
  }

  Widget _buildMedicineList(String title, List<MedicineItem> medicines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250,
          child: medicines.isEmpty
              ? Center(child: Text('No $title available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine.pharmacyName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              medicine.medicineName,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: Colors.blue),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    medicine.pharmacyPhone,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: \$${medicine.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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

  Widget _buildEquipmentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            'Mediciens',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250,
          child: _equipmentList.isEmpty
              ? Center(child: Text('No Mediciens available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _equipmentList.length,
                  itemBuilder: (context, index) {
                    final equipment = _equipmentList[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              equipment.equipmentName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              equipment.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Price: \$${equipment.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: Colors.blue),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    equipment.contactPhone,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildMedicineList('Pharmacy', _medicinesCategory1),
                        SizedBox(height: 20),
                        _buildEquipmentList(), // Added equipment list
                        SizedBox(height: 20),
                        // _buildMedicineList('Medicines', _medicinesCategory2),
                        // SizedBox(height: 20),
                        _buildMedicineList('Medicines', _medicinesCategory3),
                        SizedBox(height: 20),
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

class MedicalEquipmentItem {
  final String equipmentName;
  final String description;
  final double price;
  final String contactPhone;

  MedicalEquipmentItem({
    required this.equipmentName,
    required this.description,
    required this.price,
    required this.contactPhone,
  });
}
