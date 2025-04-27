import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Category_Challenges/enterpreneurs_challenges.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MaterialApp(
    home: EnterpreneursPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class EnterpreneursPage extends StatefulWidget {
  const EnterpreneursPage({super.key});

  @override
  State<EnterpreneursPage> createState() => _EnterpreneursPageState();
}

class _EnterpreneursPageState extends State<EnterpreneursPage> {
  String selectedOption = 'Enterpreneurs MS';
  final List<String> challenges = [
    'Enterpreneurs MS',
    'Enterpreneurs HS',
    'Enterpreneurs UP',
    'Enterpreneurs ES',
  ];

  void navigateToChallenge(String value) {
    final pages = {
      'Enterpreneurs MS': const EnterpreneursMSPage(),
      'Enterpreneurs HS': const EnterpreneursHSPage(),
      'Enterpreneurs UP': const EnterpreneursUPPage(),
      'Enterpreneurs ES': const EnterpreneursESPage(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => pages[value] ?? const EnterpreneursMSPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Challenges Rank Page",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 160, 27, 17),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => selectedOption = newValue);
                    }
                  },
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  items:
                      challenges.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => navigateToChallenge(selectedOption),
                  child: const Text(
                    "Go to Challenge Rank",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 160, 27, 17),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
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
