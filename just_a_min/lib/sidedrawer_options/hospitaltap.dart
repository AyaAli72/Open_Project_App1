import 'package:flutter/material.dart';
import 'package:just_a_min/googlesheetAPI.dart'; // Your Google Sheets API class

class HospitalTap_Page extends StatefulWidget {
  @override
  _HospitalTap_PageState createState() => _HospitalTap_PageState();
}

class _HospitalTap_PageState extends State<HospitalTap_Page> {
  // Ambulance data organized by category
  List<HospitalItem> _ambulancesCategory1 = [];
  List<HospitalItem> _ambulancesCategory2 = [];
  List<HospitalItem> _ambulancesCategory3 = [];
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
        range:
            'Hospital!A:F', // Columns A-F: Category, Name, Phone, Email, Address, Ambulance Number
      );

      // Process raw data into ambulance items
      final allAmbulances = _parseSheetData(data);

      // Categorize ambulances
      setState(() {
        _ambulancesCategory1 =
            allAmbulances.where((item) => item.category == 1).toList();
        _ambulancesCategory2 =
            allAmbulances.where((item) => item.category == 2).toList();
        _ambulancesCategory3 =
            allAmbulances.where((item) => item.category == 3).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<HospitalItem> _parseSheetData(List<List<String>> data) {
    // Skip header row if exists
    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Map columns to ambulance properties
      return HospitalItem(
        category: int.tryParse(row[0]) ?? 1, // First column = category
        name: row[1], // Second column = name
        phone: row[2], // Third column = phone
        email: row[3], // Fourth column = email
        address: row[4], // Fifth column = address
        ambulanceNumber: row[5], // Sixth column = ambulance number
      );
    }).toList();
  }

  Widget _buildAmbulanceList(String title, List<HospitalItem> ambulances) {
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
          height: 250, // Increased height for more information
          child: ambulances.isEmpty
              ? Center(child: Text('No More Hospitals available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ambulances.length,
                  itemBuilder: (context, index) {
                    final ambulance = ambulances[index];
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
                            // Name
                            Text(
                              ambulance.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // Phone with icon
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16, color: Colors.blue),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    ambulance.phone,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Email with icon
                            Row(
                              children: [
                                Icon(Icons.email,
                                    size: 16,
                                    color: Color.fromARGB(255, 39, 123, 186)),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    ambulance.email,
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Address with icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    ambulance.address,
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Ambulance Number
                            Text(
                              'Ambulance: ${ambulance.ambulanceNumber}',
                              style: TextStyle(
                                fontSize: 14,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Hospital Services",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0, // Slightly smaller for longer title
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 123, 164), // Red for emergency
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
                        _buildAmbulanceList('Hospitals', _ambulancesCategory1),
                        SizedBox(height: 12),
                        _buildAmbulanceList('Hospitals', _ambulancesCategory2),
                        SizedBox(height: 12),
                        _buildAmbulanceList('Hospitals', _ambulancesCategory3),
                      ],
                    ),
                  ),
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
