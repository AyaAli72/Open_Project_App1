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
        range: 'Hospitaldoctor!A:I', // Updated to include all 9 columns
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
        phone: row[2],
        email: row[1],
        address: row[3],
        ambulanceNumber: row[4],
      );
    }).toList();
  }

  List<DoctorItem> _parseDoctorsSheetData(List<List<String>> data) {
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Ensure row has enough elements
      while (row.length < 9) row.add('');

      return DoctorItem(
        name: row[0],
        specialization: row[1],
        price: row[2],
        date: row[3],
        hospitalName: row[4],
        hospitalPhone: row[5],
        phone: row[6], // Doctor's personal phone
        email: row[7],
        address: row[8],
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
          height: 260, // Increased height to accommodate more info
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
                          width: 200, // Increased width for more information
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
                              const SizedBox(height: 6),

                              // Specialization
                              Text(
                                doctor.specialization,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Price
                              Text(
                                "Fee: ${doctor.price}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Date
                              Text(
                                "Available: ${doctor.date}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.orange[700],
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Hospital
                              Row(
                                children: [
                                  Icon(Icons.local_hospital,
                                      size: 14, color: Colors.red),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      doctor.hospitalName,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Contact
                              Row(
                                children: [
                                  Icon(Icons.phone,
                                      size: 14, color: Colors.green),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      doctor.phone,
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 1,
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
  final String specialization;
  final String price;
  final String date;
  final String hospitalName;
  final String hospitalPhone;
  final String phone; // Doctor's personal phone
  final String email;
  final String address;

  DoctorItem({
    required this.name,
    required this.specialization,
    required this.price,
    required this.date,
    required this.hospitalName,
    required this.hospitalPhone,
    required this.phone,
    required this.email,
    required this.address,
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
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Email"),
                  _buildInfoRow(Icons.email, hospital.email, Colors.red),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Address"),
                  _buildInfoRow(
                      Icons.location_on, hospital.address, Colors.orange),
                  SizedBox(
                    height: 15,
                  ),
                  _buildSectionHeader("Ambulances"),
                  _buildInfoRow(Icons.local_hospital, hospital.ambulanceNumber,
                      Colors.purple),
                  SizedBox(
                    height: 15,
                  ),
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
      body: SingleChildScrollView(
        child: Center(
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
                    // Doctor Basic Info
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue[100],
                            child: Icon(Icons.person,
                                size: 50, color: Colors.blue),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            doctor.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(thickness: 1, height: 30),

                    // Professional Information
                    _buildSectionHeader("Professional Information"),
                    _buildInfoRow(Icons.medical_services, "Specialization",
                        doctor.specialization),
                    _buildInfoRow(
                        Icons.attach_money, "Consultation Fee", doctor.price),
                    _buildInfoRow(
                        Icons.calendar_today, "Next Available", doctor.date),

                    // Hospital Information
                    _buildSectionHeader("Hospital Information"),
                    _buildInfoRow(
                        Icons.local_hospital, "Hospital", doctor.hospitalName),
                    _buildInfoRow(
                        Icons.phone, "Hospital Phone", doctor.hospitalPhone),

                    // // Contact Information
                    // _buildSectionHeader("Contact Information"),
                    // _buildInfoRow(Icons.phone, "Personal Phone", doctor.phone),
                    // _buildInfoRow(Icons.email, "Email", doctor.email),
                    // _buildInfoRow(Icons.location_on, "Address", doctor.address),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[700]),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 250,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
