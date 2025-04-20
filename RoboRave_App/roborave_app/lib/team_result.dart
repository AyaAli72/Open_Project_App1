import 'package:flutter/material.dart';

class TeamResultPage extends StatefulWidget {
  @override
  _TeamResultPageState createState() => _TeamResultPageState();
}

class _TeamResultPageState extends State<TeamResultPage> {
  final TextEditingController _teamNumberController = TextEditingController();
  @override
  void dispose() {
    _teamNumberController.dispose();
    super.dispose(); // Don't forget this!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Team Result Page",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 160, 27, 17),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _teamNumberController,
                  decoration: InputDecoration(
                    labelText: 'Please, Enter your Team Number(Code)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
