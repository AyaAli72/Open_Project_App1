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
  List<DoctorItem> _doctorsList = []; // New list for doctors data

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

      // Fetch doctors data from another sheet
      final doctorsData = await GoogleSheetsApi.getData(
        spreadsheetId: '1C5PoYWHCdwcAAGQVd9RJokLj3jPbrKGW-Byg7YJF85M',
        range: 'Hospitaldoctor!A:F', // Adjust range to match your sheet
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
      return HospitalItem(
        category: int.tryParse(row[0]) ?? 1,
        name: row[0], // Fixed index
        phone: row[1], // Fixed index
        email: row[2], // Fixed index
        address: row[3], // Fixed index
        ambulanceNumber: row[4], // Fixed index
      );
    }).toList();
  }

  List<DoctorItem> _parseDoctorsSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      return DoctorItem(
        name: row[0],
        phone: row[1],
        email: row[2],
        address: row[3],
        specialization: row[4],
      );
    }).toList();
  }

  Widget _buildAmbulanceList(String title, List<HospitalItem> ambulances) {
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
          child: ambulances.isEmpty
              ? Center(child: Text('No $title available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ambulances.length,
                  itemBuilder: (context, index) {
                    final ambulance = ambulances[index];
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
                              ambulance.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: Colors.blue),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    ambulance.phone,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.email,
                                    size: 18,
                                    color: Color.fromARGB(255, 39, 123, 186)),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    ambulance.email,
                                    style: TextStyle(fontSize: 14),
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
                                    size: 18, color: Colors.green),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    ambulance.address,
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Ambulance: ${ambulance.ambulanceNumber}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
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

  Widget _buildDoctorsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            'Doctors',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 250,
          child: _doctorsList.isEmpty
              ? Center(child: Text('No doctors available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _doctorsList.length,
                  itemBuilder: (context, index) {
                    final doctor = _doctorsList[index];
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
                              doctor.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              doctor.specialization,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 18, color: Colors.blue),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    doctor.phone,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.email,
                                    size: 18,
                                    color: Color.fromARGB(255, 39, 123, 186)),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    doctor.email,
                                    style: TextStyle(fontSize: 14),
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
                                    size: 18, color: Colors.green),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    doctor.address,
                                    style: TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
          "Hospital Services",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 123, 164),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            _buildAmbulanceList(
                                'Hospitals', _ambulancesCategory1),
                            SizedBox(height: 20),
                            _buildAmbulanceList(
                                'Clinics', _ambulancesCategory2),
                            SizedBox(height: 20),
                            _buildAmbulanceList(
                                'Specialized Centers', _ambulancesCategory3),
                            SizedBox(height: 20),
                            _buildDoctorsList(), // Added doctors list
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
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
                    ),
                  ],
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

// New class for doctors data
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
