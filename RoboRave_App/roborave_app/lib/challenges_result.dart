import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'googlesheetapi.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env'); // Must be before runApp()
  runApp(MaterialApp(
    home: ChallengeResultPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ChallengeResultPage extends StatefulWidget {
  const ChallengeResultPage({super.key});

  @override
  State<ChallengeResultPage> createState() => _ChallengeResultPageState();
}

class _ChallengeResultPageState extends State<ChallengeResultPage> {
  String selectedOption = 'Sumo Cup';
  final List<String> challenges = [
    'Sumo Cup',
    'Maze Solver',
    'Fire Fighter',
    'Line Follower',
    'Airpline',
    'Fastbot',
    'Preshcool',
    'Enterpreneurs(open project)'
  ];

  void navigateToChallenge(String value) {
    final pages = {
      'Sumo Cup': const SumoCupPage(),
      'Maze Solver': const MazeSolverPage(),
      'Fire Fighter': const FireFighterPage(),
      'Line Follower': const LineFollowerPage(),
      'Airpline': const AirplinePage(),
      'Fastbot': const FastbotPage(),
      'Preshcool': const PreschoolPage(),
      'Enterpreneurs(open project)': const EnterpreneursPage(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => pages[value] ?? const SumoCupPage()),
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

// Challenge Pages

class SumoCupPage extends StatefulWidget {
  const SumoCupPage({super.key});

  @override
  State<SumoCupPage> createState() => _SumoCupPageState();
}

class _SumoCupPageState extends State<SumoCupPage> {
  List<List<String>> sheetData = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      const spreadsheetId =
          '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic'; // Replace with your ID
      const range = 'RoboRaveEgyptResultsScoreSheet!A3:C3';

      final data = await GoogleSheetsApi.getSheetData(spreadsheetId, range);
      setState(() {
        sheetData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sumo Cup Challenge")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: sheetData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(sheetData[index].join(' | ')),
                    );
                  },
                ),
    );
  }
}

class MazeSolverPage extends StatelessWidget {
  const MazeSolverPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Maze Solver");
}

class FireFighterPage extends StatelessWidget {
  const FireFighterPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Fire Fighter");
}

class LineFollowerPage extends StatelessWidget {
  const LineFollowerPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Maze Solver");
}

class AirplinePage extends StatelessWidget {
  const AirplinePage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Fire Fighter");
}

class FastbotPage extends StatelessWidget {
  const FastbotPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Maze Solver");
}

class PreschoolPage extends StatelessWidget {
  const PreschoolPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Maze Solver");
}

class EnterpreneursPage extends StatelessWidget {
  const EnterpreneursPage({super.key});

  @override
  Widget build(BuildContext context) => _buildChallengePage("Maze Solver");
}

Widget _buildChallengePage(String title) {
  return Scaffold(
    appBar: AppBar(title: Text("$title Challenge")),
    body: const Center(child: Text("Challenge data will be displayed here")),
  );
}
