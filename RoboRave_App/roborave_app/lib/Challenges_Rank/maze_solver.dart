import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Category_Challenges/mazesolver_challenge.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MaterialApp(
    home: MazeSolverPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MazeSolverPage extends StatefulWidget {
  const MazeSolverPage({super.key});

  @override
  State<MazeSolverPage> createState() => _MazeSolverPageState();
}

class _MazeSolverPageState extends State<MazeSolverPage> {
  String selectedOption = 'Maze Solver MS';
  final List<String> challenges = [
    'Maze Solver MS',
    'Maze Solver ES',
    'Maze Solver ES Manual',
  ];

  void navigateToChallenge(String value) {
    final pages = {
      'Maze Solver MS': const MazeSolverMSPage(),
      'Maze Solver ES Manual': const MazeSolverESManualPage(),
      'Maze Solver ES ': const MazeSolverESPage(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => pages[value] ?? const MazeSolverESPage()),
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
