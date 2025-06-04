import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart';
import 'package:just_a_min/adddoctors.dart';

class HospitalTap_Page extends StatefulWidget {
  @override
  _HospitalTap_PageState createState() => _HospitalTap_PageState();
}

class _HospitalTap_PageState extends State<HospitalTap_Page> {
  List<HospitalItem> _ambulancesCategory1 = [];
  List<HospitalItem> _ambulancesCategory2 = [];
  List<HospitalItem> _ambulancesCategory3 = [];
  List<DoctorItem> _doctorsList = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      // Fetch hospital data
      final hospitalData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Hospital!A:F',
      );
      final allAmbulances = _parseHospitalSheetData(hospitalData);

      // Fetch doctors data
      final doctorsData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Hospitaldoctor!A:F',
      );
      final doctors = _parseDoctorsSheetData(doctorsData);

      setState(() {
        _ambulancesCategory1 =
            allAmbulances.where((item) => item.category == 1).toList();
        _ambulancesCategory2 =
            allAmbulances.where((item) => item.category == 2).toList();
        _ambulancesCategory3 =
            allAmbulances.where((item) => item.category == 3).toList();
        _doctorsList = doctors;
        _isLoading = false;
      });
    } catch (e) {
    setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<HospitalItem> _parseHospitalSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Ensure row has enough elements
      while (row.length < 6) row.add('');

      return HospitalItem(
        category: int.tryParse(row[0]) ?? 1,
        name: row[0],
        phone: row[1],
        email: row[2],
        address: row[3],
        ambulanceNumber: row[4],
      );
    }).toList();
  }

  List<DoctorItem> _parseDoctorsSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Ensure row has enough elements
      while (row.length < 5) row.add('');

      return DoctorItem(
        name: row[0],
        phone: row[1],
        email: row[2],
        address: row[3],
        specialization: row[4],
      );
    }).toList();
  }

  Widget _buildHospitalList(String title, List<HospitalItem> hospitals) {
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
          child: hospitals.isEmpty
              ? Center(child: Text('No hospitals available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = hospitals[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HospitalDetailPage(hospital: hospital),
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
                                hospital.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 16, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    hospital.phone,
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
                                      hospital.email,
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      hospital.address,
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ambulances: ${hospital.ambulanceNumber}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
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

  Widget _buildDoctorsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doctors',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 240,
          child: _doctorsList.isEmpty
              ? Center(child: Text('No doctors available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _doctorsList.length,
                  itemBuilder: (context, index) {
                    final doctor = _doctorsList[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      doctor.address,
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
          "Hospital Services",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 145, 221),
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
                        _buildHospitalList('Hospitals', _ambulancesCategory1),
                        const SizedBox(height: 12),
                        _buildHospitalList('Clinics', _ambulancesCategory2),
                        const SizedBox(height: 12),
                        _buildHospitalList(
                            'Specialized Centers', _ambulancesCategory3),
                        const SizedBox(height: 12),
                        _buildDoctorsList(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDoctorsPage(),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

class HospitalItem {
  final int category;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String ambulanceNumber;

  HospitalItem({
    required this.category,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.ambulanceNumber,
  });
}

class DoctorItem {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String specialization;

  DoctorItem({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.specialization,
  });
}

class HospitalDetailPage extends StatelessWidget {
  final HospitalItem hospital;

  HospitalDetailPage({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          hospital.name,
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
                  _buildSectionHeader("Contact"),
                  _buildInfoRow(Icons.phone, hospital.phone, Colors.green),
                  _buildSectionHeader("Email"),
                  _buildInfoRow(Icons.email, hospital.email, Colors.red),
                  _buildSectionHeader("Address"),
                  _buildInfoRow(
                      Icons.location_on, hospital.address, Colors.orange),
                  _buildSectionHeader("Ambulances"),
                  _buildInfoRow(Icons.local_hospital, hospital.ambulanceNumber,
                      Colors.purple),
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
                  _buildSectionHeader("Specialization"),
                  _buildInfoRow(Icons.medical_services, doctor.specialization,
                      Colors.deepPurple),
                  _buildSectionHeader("Contact"),
                  _buildInfoRow(Icons.phone, doctor.phone, Colors.green),
                  _buildSectionHeader("Email"),
                  _buildInfoRow(Icons.email, doctor.email, Colors.red),
                  _buildSectionHeader("Address"),
                  _buildInfoRow(
                      Icons.location_on, doctor.address, Colors.orange),
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
