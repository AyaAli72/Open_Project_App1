import 'package:flutter/material.dart';

class AddMaterialPage extends StatefulWidget {
  @override
  _AddMaterialPageState createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final TextEditingController _MaerialDetailsController =
      TextEditingController();
  final TextEditingController _MaerialAmountController =
      TextEditingController();
  final TextEditingController _MaerialPriceController = TextEditingController();

  @override
  void dispose() {
    _MaerialDetailsController.dispose();
    _MaerialAmountController.dispose();
    _MaerialPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Material Page",
          style: TextStyle(
              color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 225, 225),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          // Your main content goes here
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(
                  controller: _MaerialDetailsController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Material Details',
                    border: OutlineInputBorder(),
                  ),
                ),
              const   SizedBox(
                  height: 20,
                  width: 20,
                ),
                TextField(
                  controller: _MaerialAmountController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Material Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              const  SizedBox(
                  height: 20,
                  width: 20,
                ),
                TextField(
                  controller: _MaerialPriceController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Material Price',
                    border: OutlineInputBorder(),
                  ),
                ),
               const SizedBox(
                  height: 20,
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.green),
                    onPressed: () {},
                    child:const  Text(
                      "Add Material",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
