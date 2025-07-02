import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  // Sample restaurant data
  final List<Map<String, String>> restaurants = [
    {
      "name": "Flame Grill",
      "details": "Fresh burgers and BBQ meals",
      "location": "Downtown, Cairo",
      "rating": "4.5",
      "open": "Open 10 AM - 11 PM"
    },
    {
      "name": "Sushi Corner",
      "details": "Authentic Japanese cuisine",
      "location": "Zamalek, Cairo",
      "rating": "4.7",
      "open": "Open 12 PM - 10 PM"
    },
    {
      "name": "Pasta House",
      "details": "Italian pasta and pizza",
      "location": "Alexandria, Corniche",
      "rating": "4.3",
      "open": "Open 1 PM - 12 AM"
    },
    {
      "name": "Grill House Express",
      "description": "American-style burgers and steaks.",
      "Location": "Nasr City",
      "rating": "4.3",
      "open": "Open 1 PM - 12 AM"
    },
    {
      "name": "Sakura Sushi",
      "description": "Fresh Japanese sushi and rolls.",
      "Location": "Alexandria Corniche",
      "rating": "4.7",
      "open": "Open 12 PM - 11 PM"
    },
    {
      "name": "Mama Mia Trattoria",
      "description": "Delicious homemade Italian pasta.",
      "Location": "Zamalek, Cairo",
      "rating": "4.8",
      "open": "Open 1 PM - 12 AM"
    },
    {
      "name": "Grill House Express",
      "description": "American-style burgers and steaks.",
      "Location": "Nasr City",
      "rating": "4.3",
      "open": "Open 1 PM - 12 AM"
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
          "Restaurant Page",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            elevation: 8,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Icon(Icons.restaurant_menu,
                  size: 40, color: Colors.deepPurple),
              title: Text(restaurant['name'] ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(restaurant['details'] ?? "",
                  style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: const Color.fromARGB(255, 248, 247, 247)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailsPage(restaurant: restaurant),
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

class RestaurantDetailsPage extends StatelessWidget {
  final Map<String, String> restaurant;

  const RestaurantDetailsPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(restaurant['name'] ?? "Details",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${restaurant['name']}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text("Details: ${restaurant['details']}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Location: ${restaurant['location']}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Rating: ${restaurant['rating']} ⭐",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text("Working Hours: ${restaurant['open']}",
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
