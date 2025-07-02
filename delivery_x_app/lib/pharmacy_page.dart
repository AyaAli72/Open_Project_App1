import 'package:flutter/material.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  // Sample pharmacy data
  final List<Map<String, String>> pharmacies = [
    {
      "name": "El Ezaby Pharmacy",
      "details": "24/7 pharmacy offering a wide range of medicines.",
      "location": "Nasr City, Cairo",
      "rating": "4.6",
      "open": "Open 24 hours"
    },
    {
      "name": "Roshdy Pharmacy",
      "details": "Well-known pharmacy with delivery service.",
      "location": "Smouha, Alexandria",
      "rating": "4.5",
      "open": "Open 9 AM - 11 PM"
    },
    {
      "name": "Seif Pharmacy",
      "details": "Health, beauty, and prescription medicine provider.",
      "location": "Dokki, Giza",
      "rating": "4.7",
      "open": "Open 8 AM - 12 AM"
    },
    {
      "name": "19011 Pharmacy",
      "details": "Extensive pharmacy network with mobile ordering.",
      "location": "New Cairo",
      "rating": "4.2",
      "open": "Open 10 AM - 10 PM"
    },
    {
      "name": "El Dawaa Pharmacy",
      "details": "Top pharmaceutical and cosmetic products.",
      "location": "Maadi, Cairo",
      "rating": "4.4",
      "open": "Open 24 hours"
    },
    {
      "name": "United Pharmacy",
      "details": "Affordable medicine and baby care products.",
      "location": "Heliopolis, Cairo",
      "rating": "4.3",
      "open": "Open 10 AM - 12 AM"
    },
    {
      "name": "Cure Pharmacy",
      "details": "Your trusted partner in health and wellness.",
      "location": "Zamalek, Cairo",
      "rating": "4.6",
      "open": "Open 9 AM - 11 PM"
    },
    {
      "name": "Good Life Pharmacy",
      "details": "Organic products and prescription drugs.",
      "location": "Sheraton, Cairo",
      "rating": "4.1",
      "open": "Open 8 AM - 10 PM"
    },
    {
      "name": "Health First Pharmacy",
      "details": "Committed to community healthcare services.",
      "location": "Mohandessin, Giza",
      "rating": "4.5",
      "open": "Open 24 hours"
    },
    {
      "name": "WellCare Pharmacy",
      "details": "Premium pharmacy with modern facilities.",
      "location": "5th Settlement, New Cairo",
      "rating": "4.8",
      "open": "Open 9 AM - 1 AM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Pharmacy Page",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: pharmacies.length,
        itemBuilder: (context, index) {
          final pharmacy = pharmacies[index];
          return Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Icon(Icons.local_pharmacy,
                  size: 40, color: Colors.deepPurple),
              title: Text(pharmacy['name'] ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(pharmacy['details'] ?? "",
                  style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 248, 247, 247)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PharmacyDetailsPage(pharmacy: pharmacy),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PharmacyDetailsPage extends StatelessWidget {
  final Map<String, String> pharmacy;

  const PharmacyDetailsPage({Key? key, required this.pharmacy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(pharmacy['name'] ?? "Details",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${pharmacy['name']}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Details: ${pharmacy['details']}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Location: ${pharmacy['location']}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Rating: ${pharmacy['rating']} ⭐",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Working Hours: ${pharmacy['open']}",
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
