import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart';

class PharmacyTap_Page extends StatefulWidget {
  @override
  _PharmacyTap_PageState createState() => _PharmacyTap_PageState();
}

class _PharmacyTap_PageState extends State<PharmacyTap_Page> {
  List<MedicineItem> _medicinesCategory1 = [];
  List<MedicineItem> _medicinesCategory3 = [];
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
        range: 'Pharmacy!A2:D',
      );
      final allMedicines = _parsePharmacySheetData(pharmacyData);

      // Fetch medical equipment data
      final equipmentData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Mediciens!A:D',
      );
      final equipment = _parseEquipmentSheetData(equipmentData);

      setState(() {
        _medicinesCategory1 =
            allMedicines.where((item) => item.category == 1).toList();
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
      while (row.length < 4) row.add('');

      return MedicineItem(
        category: int.tryParse(row[0]) ?? 1,
        pharmacyName: row[0],
        medicineName: row[1],
        pharmacyPhone: row[2],
        price: double.tryParse(row[3] ?? '0') ?? 0.0,
      );
    }).toList();
  }

  List<MedicalEquipmentItem> _parseEquipmentSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      while (row.length < 4) row.add('');

      return MedicalEquipmentItem(
        equipmentName: row[0],
        description: row[1],
        price: double.tryParse(row[2] ?? '0') ?? 0.0,
        contactPhone: row[3],
      );
    }).toList();
  }

  Widget _buildMedicineList(String title, List<MedicineItem> medicines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 240,
          child: medicines.isEmpty
              ? Center(child: Text('No $title available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MedicineDetailPage(medicine: medicine),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(8),
                        elevation: 4,
                        child: Container(
                          width: 180,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medicine.medicineName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                medicine.pharmacyName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    medicine.pharmacyPhone,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: \$${medicine.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
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
        Text(
          'Medical Equipment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 240,
          child: _equipmentList.isEmpty
              ? Center(child: Text('No medical equipment available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _equipmentList.length,
                  itemBuilder: (context, index) {
                    final equipment = _equipmentList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EquipmentDetailPage(equipment: equipment),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(8),
                        elevation: 4,
                        child: Container(
                          width: 180,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                equipment.equipmentName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                equipment.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    equipment.contactPhone,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: \$${equipment.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
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
                        _buildMedicineList('Pharmacies', _medicinesCategory1),
                        const SizedBox(height: 12),
                        _buildEquipmentList(),
                        const SizedBox(height: 12),
                        _buildMedicineList('Medicines', _medicinesCategory3),
                        const SizedBox(height: 20),
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

class MedicineDetailPage extends StatelessWidget {
  final MedicineItem medicine;

  MedicineDetailPage({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          medicine.medicineName,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Pharmacy"),
                  _buildInfoRow(Icons.local_pharmacy, medicine.pharmacyName,
                      Colors.deepPurple),
                  _buildSectionHeader("Medicine"),
                  _buildInfoRow(
                      Icons.medication, medicine.medicineName, Colors.blue),
                  _buildSectionHeader("Contact"),
                  _buildInfoRow(
                      Icons.phone, medicine.pharmacyPhone, Colors.green),
                  _buildSectionHeader("Price"),
                  _buildInfoRow(Icons.attach_money,
                      '\$${medicine.price.toStringAsFixed(2)}', Colors.green),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class EquipmentDetailPage extends StatelessWidget {
  final MedicalEquipmentItem equipment;

  EquipmentDetailPage({required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          equipment.equipmentName,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Equipment"),
                  _buildInfoRow(Icons.medical_services, equipment.equipmentName,
                      Colors.blue),
                  _buildSectionHeader("Description"),
                  _buildInfoRow(
                      Icons.description, equipment.description, Colors.grey),
                  _buildSectionHeader("Contact"),
                  _buildInfoRow(
                      Icons.phone, equipment.contactPhone, Colors.green),
                  _buildSectionHeader("Price"),
                  _buildInfoRow(Icons.attach_money,
                      '\$${equipment.price.toStringAsFixed(2)}', Colors.green),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
