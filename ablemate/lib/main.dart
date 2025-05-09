import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App!!',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Able mate'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _UserNameController = TextEditingController();
  final TextEditingController _UserAgeController = TextEditingController();
  final TextEditingController _UserGanderController = TextEditingController();
  final TextEditingController _UserPhoneController = TextEditingController();
  @override
  void dispose() {
    _UserNameController.dispose();
    _UserAgeController.dispose();
    _UserGanderController.dispose();
    _UserPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 90, 189),
        title: Text(
          'Ablemate',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Personal Information",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _UserNameController,
              decoration: InputDecoration(labelText: "Please entre your name"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _UserAgeController,
              decoration: InputDecoration(labelText: "Please entre your age"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _UserPhoneController,
              decoration:
                  InputDecoration(labelText: "Please entre your phone number"),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _UserGanderController,
              decoration:
                  InputDecoration(labelText: "Please entre your gender"),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {},
              child: Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
