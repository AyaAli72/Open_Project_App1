import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart'; // Make sure this API is properly set up

void main() {
  runApp(MaterialApp(
    home: DoctorTap_Page(),
    debugShowCheckedModeBanner: false,
  ));
}

class DoctorTap_Page extends StatefulWidget {
  @override
  _DoctorTap_PageState createState() => _DoctorTap_PageState();
}

class _DoctorTap_PageState extends State<DoctorTap_Page> {
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
      final data = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Doctor!A:G',
      );

      final allDoctors = _parseSheetData(data);

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
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      while (row.length < 7) {
        row.add('');
      }

      return DoctorItem(
        category: int.tryParse(row[0]) ?? 1,
        name: row[0],
        phone: row[1],
        email: row[2],
        specialization: row[3],
        certificate: row[4],
        workplace: row[5],
      );
    }).toList();
  }

  Widget _buildDoctorList(String title, List<DoctorItem> doctors) {
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
          child: doctors.isEmpty
              ? Center(child: Text('No doctors available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorDetailPage(doctor: doctor),
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
                                doctor.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                doctor.specialization,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 8),
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
                                  Icon(Icons.email,
                                      size: 16, color: Colors.red),
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
                        _buildDoctorList('Doctor', _doctorsCategory1),
                        const SizedBox(height: 12),
                        _buildDoctorList('Doctor', _doctorsCategory2),
                        const SizedBox(height: 12),
                        _buildDoctorList('Doctor', _doctorsCategory3),
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

class DoctorDetailPage extends StatelessWidget {
  final DoctorItem doctor;

  DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          doctor.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
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
                  _buildSectionHeader("Specialization"),
                  _buildInfoRow(Icons.medical_services, doctor.specialization,
                      Colors.deepPurple),
                  _buildSectionHeader("Workplace"),
                  _buildInfoRow(
                      Icons.location_on, doctor.workplace, Colors.orange),
                  _buildSectionHeader("Phone"),
                  _buildInfoRow(Icons.phone, doctor.phone, Colors.green),
                  _buildSectionHeader("Email"),
                  _buildInfoRow(Icons.email, doctor.email, Colors.red),
                  _buildSectionHeader("Certificate"),
                  _buildInfoRow(
                      Icons.verified, doctor.certificate, Colors.teal),
                  _buildSectionHeader("Category"),
                  _buildInfoRow(Icons.category, 'Category ${doctor.category}',
                      Colors.blueGrey),
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
          letterSpacing: 0.5,
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
              text.isNotEmpty ? text : "Not Available",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
