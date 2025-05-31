import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart'; // Your Google Sheets API class

class DoctorTap_Page extends StatefulWidget {
  @override
  _DoctorTap_PageState createState() => _DoctorTap_PageState();
}

class _DoctorTap_PageState extends State<DoctorTap_Page> {
  // Doctor data organized by category
  List<DoctorItem> _doctorsCategory1 = [];
  List<DoctorItem> _doctorsCategory2 = [];
  List<DoctorItem> _doctorsCategory3 = [];
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
        range: 'Doctor!A:F', // CORRECTED: Changed to A:G for 7 columns
      );

      // Process raw data into doctor items
      final allDoctors = _parseSheetData(data);

      // Categorize doctors
      setState(() {
        _doctorsCategory1 =
            allDoctors.where((item) => item.category == 1).toList();
        _doctorsCategory2 =
            allDoctors.where((item) => item.category == 2).toList();
        _doctorsCategory3 =
            allDoctors.where((item) => item.category == 3).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<DoctorItem> _parseSheetData(List<List<String>> data) {
    // Skip header row if exists
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Handle rows with insufficient columns
      if (row.length < 7) {
        // Add empty strings for missing columns
        while (row.length < 7) {
          row.add('');
        }
      }

      // Map columns to doctor properties
      return DoctorItem(
        category: int.tryParse(row[0]) ?? 1, // First column = category
        name: row[1], // Second column = name
        phone: row[2], // Third column = phone
        email: row[3], // Fourth column = email
        specialization: row[4], // Fifth column = specialization
        certificate: row[5], // Sixth column = certificate
        workplace: row[6], // Seventh column = workplace
      );
    }).toList();
  }

  Widget _buildDoctorList(String title, List<DoctorItem> doctors) {
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
          height: 240,
          child: doctors.isEmpty
              ? Center(child: Text('No doctors available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      elevation: 4,
                      child: Container(
                        width: 180,
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Doctor name
                            Text(
                              doctor.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Specialization
                            Text(
                              doctor.specialization,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Workplace
                            Row(
                              children: [
                                Icon(Icons.work,
                                    size: 16, color: Colors.orange),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    doctor.workplace,
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Contact information
                            Row(
                              children: [
                                Icon(Icons.phone,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 4),
                                Text(
                                  doctor.phone,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              children: [
                                Icon(Icons.email, size: 16, color: Colors.red),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    doctor.email,
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Certificate indicator
                            Row(
                              children: [
                                Icon(Icons.verified,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 4),
                                Text(
                                  doctor.certificate.isNotEmpty
                                      ? doctor.certificate
                                      : 'Certified',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
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
          "Doctors",
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
                        _buildDoctorList('Doctors', _doctorsCategory1),
                        SizedBox(height: 12),
                        _buildDoctorList('Doctors', _doctorsCategory2),
                        SizedBox(height: 12),
                        _buildDoctorList('Doctors', _doctorsCategory3),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class DoctorItem {
  final int category;
  final String name;
  final String phone;
  final String email;
  final String specialization;
  final String certificate;
  final String workplace;

  DoctorItem({
    required this.category,
    required this.name,
    required this.phone,
    required this.email,
    required this.specialization,
    required this.certificate,
    required this.workplace,
  });
}
