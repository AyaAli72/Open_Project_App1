import 'package:flutter/material.dart';

class BlindPage extends StatefulWidget {
  @override
  _BlindPageState createState() => _BlindPageState();
}

class _BlindPageState extends State<BlindPage> {
  final TextEditingController _TextController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _TextController.dispose();
  }

  void outputVoice() {}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Helping Blind Page',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                maxLines: 30,
                controller: _TextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      "Please Enter the Text You Want to Convert It into Voice",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the Text You Want to Convert It into Voice';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  outputVoice();
                },
                child: Text(
                  "Convert",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
