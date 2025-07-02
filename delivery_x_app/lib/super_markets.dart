import 'package:flutter/material.dart';

class SuperMarketsPage extends StatefulWidget {
  @override
  _SuperMarketsPageState createState() => _SuperMarketsPageState();
}

class _SuperMarketsPageState extends State<SuperMarketsPage> {
  final List<Map<String, String>> superMarkets = [
    {
      "name": "Carrefour",
      "details":
          "One of the largest international hypermarkets, offering groceries, electronics, and household goods.",
      "location": "City Centre Alexandria",
      "rating": "4.5",
      "open": "Open 9 AM - 12 AM"
    },
    {
      "name": "Seoudi Market",
      "details":
          "Premium supermarket chain with high-quality imported products.",
      "location": "Zamalek, Cairo",
      "rating": "4.3",
      "open": "Open 9 AM - 11 PM"
    },
    {
      "name": "Gourmet Egypt",
      "details":
          "Specialty supermarket known for fresh produce, meat, and imported food items.",
      "location": "New Cairo",
      "rating": "4.6",
      "open": "Open 8 AM - 10 PM"
    },
    {
      "name": "Metro Market",
      "details":
          "Trusted chain of stores offering a wide selection of groceries and personal care items.",
      "location": "Nasr City, Cairo",
      "rating": "4.4",
      "open": "Open 24 hours"
    },
    {
      "name": "Kazyon",
      "details":
          "Affordable supermarket with daily discounts and essential groceries.",
      "location": "Smouha, Alexandria",
      "rating": "4.2",
      "open": "Open 9 AM - 12 AM"
    },
    {
      "name": "Ragab Sons",
      "details":
          "Family-friendly supermarket offering groceries and fresh produce.",
      "location": "Mohandessin, Giza",
      "rating": "4.1",
      "open": "Open 9 AM - 11 PM"
    },
    {
      "name": "Awlad Ragab",
      "details": "One of Egypt’s popular supermarkets with regular offers.",
      "location": "Heliopolis, Cairo",
      "rating": "4.3",
      "open": "Open 8 AM - 11 PM"
    },
    {
      "name": "Hyper One",
      "details":
          "Massive hypermarket offering groceries, clothing, and appliances.",
      "location": "6th of October City",
      "rating": "4.7",
      "open": "Open 9 AM - 2 AM"
    },
    {
      "name": "Spinneys",
      "details":
          "Upscale supermarket chain with a wide variety of local and imported goods.",
      "location": "5th Settlement, New Cairo",
      "rating": "4.4",
      "open": "Open 10 AM - 11 PM"
    },
    {
      "name": "BIM",
      "details": "Discount supermarket with Turkish and local goods.",
      "location": "Sidi Gaber, Alexandria",
      "rating": "4.0",
      "open": "Open 8 AM - 10 PM"
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
          "Super Markets Page",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: superMarkets.length,
        itemBuilder: (context, index) {
          final market = superMarkets[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                market['name']!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text("Rating: ${market['rating']} | ${market['open']}"),
              trailing: Icon(Icons.store, color: Colors.deepPurple),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SuperMarketDetailsPage(market: market),
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

class SuperMarketDetailsPage extends StatelessWidget {
  final Map<String, String> market;

  const SuperMarketDetailsPage({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(market['name']!, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Details:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(market['details']!, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Location: ${market['location']!}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Rating: ${market['rating']!} ⭐",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Working Hours: ${market['open']!}",
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
