import 'package:flutter/material.dart';
import 'addmaterial.dart';

class MaterialShowPage extends StatefulWidget {
  @override
  _MaterialShowPageState createState() => _MaterialShowPageState();
}

class _MaterialShowPageState extends State<MaterialShowPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "0 Waste HUb",
          style: TextStyle(
              color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 225, 225),
      ),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              // Your main content goes here
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Material Show ',
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(height: 800), // Just to make the page scrollable
                  ],
                ),
              ),
            ),
          ),

          // Fixed position FAB
          Positioned(
            left: 16,
            bottom: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMaterialPage(),
                    ),
                  );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
