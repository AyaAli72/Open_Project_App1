import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart';

class PharmacyTap_Page extends StatefulWidget {
  @override
  _PharmacyTap_PageState createState() => _PharmacyTap_PageState();
}

class _PharmacyTap_PageState extends State<PharmacyTap_Page> {
  List<PharmacyItem> _medicinesCategory1 = [];
  List<PharmacyItem> _medicinesCategory3 = [];
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
        range: 'Pharmacy!A1:D',
      );
      final allMedicines = _parsePharmacySheetData(pharmacyData);

      // Fetch medical equipment data
      final equipmentData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Mediciens!A1:E',
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

  List<PharmacyItem> _parsePharmacySheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      while (row.length < 5) row.add('');

      return PharmacyItem(
        category: int.tryParse(row[0]) ?? 1,
        pharmacyName: row[0],
        pharmacyEmail: row[2],
        pharmacyPhone: row[1],
        address: row[3],
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
        price: double.tryParse(row[2]) ?? 0.0,
        contactPhone: row[4],
        pharmacyName: row[3],
      );
    }).toList();
  }

  Widget _buildPharmacyList(String title, List<PharmacyItem> pharmacies) {
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
          child: pharmacies.isEmpty
              ? Center(child: Text('No $title available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pharmacies.length,
                  itemBuilder: (context, index) {
                    final pharmacy = pharmacies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PharmacyDetailPage(pharmacy: pharmacy),
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
                                pharmacy.pharmacyName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.email,
                                      size: 16, color: Colors.red),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      pharmacy.pharmacyEmail,
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    pharmacy.pharmacyPhone,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
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
                        _buildPharmacyList('Pharmacies', _medicinesCategory1),
                        const SizedBox(height: 12),
                        _buildEquipmentList(),
                        const SizedBox(height: 12),
                        _buildPharmacyList('Medicines', _medicinesCategory3),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class PharmacyItem {
  final int category;
  final String pharmacyName;
  final String pharmacyEmail;
  final String pharmacyPhone;
  final String address;

  PharmacyItem({
    required this.category,
    required this.pharmacyName,
    required this.pharmacyEmail,
    required this.pharmacyPhone,
    required this.address,
  });
}

class MedicalEquipmentItem {
  final String equipmentName;
  final String description;
  final double price;
  final String contactPhone;
  final String pharmacyName;

  MedicalEquipmentItem({
    required this.equipmentName,
    required this.description,
    required this.price,
    required this.contactPhone,
    required this.pharmacyName,
  });
}

class PharmacyDetailPage extends StatelessWidget {
  final PharmacyItem pharmacy;

  PharmacyDetailPage({required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          pharmacy.pharmacyName,
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
                  _buildSectionHeader("Pharmacy Information"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(
                      Icons.local_pharmacy, "Name", pharmacy.pharmacyName),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Contact Information"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.email, "Email", pharmacy.pharmacyEmail),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.phone, "Phone", pharmacy.pharmacyPhone),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.location_on, "Address", pharmacy.address),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
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
                  _buildSectionHeader("Equipment Information"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(
                      Icons.medical_services, "Name", equipment.equipmentName),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Details"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(
                      Icons.description, "Description", equipment.description),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.attach_money, "Price",
                      '\$${equipment.price.toStringAsFixed(2)}'),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Contact"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.phone, "Phone", equipment.contactPhone),
                  SizedBox(
                    height: 15,
                  ),
                  _buildInfoRow(Icons.local_pharmacy, "Pharmacy Name",
                      equipment.pharmacyName),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
