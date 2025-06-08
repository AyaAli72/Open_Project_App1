import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Challenges_Rank/sumocup.dart';
import 'Challenges_Rank/maze_solver.dart';
import 'Challenges_Rank/line_follower.dart';
import 'Challenges_Rank/fire_fighter.dart';
import 'Challenges_Rank/airpline.dart';
import 'Challenges_Rank/fastbot.dart';
import 'Challenges_Rank/preschool.dart';
import 'Challenges_Rank/Enterpreneurs.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MaterialApp(
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
    'Enterpreneurs'
  ];

  void navigateToChallenge(String value) {
    final pages = {
      'Sumo Cup': const SumoCupPage(),
      'Maze Solver': const MazeSolverPage(),
      'Fire Fighter': const FireFighterPage(),
      'Line Follower': const LineFollowerPage(),
      'Airpline': const AirplinePage(),
      'Fastbot': const FastbotPage(),
      'Preshcool': const PreSchoolPage(),
      'Enterpreneurs': const EnterpreneursPage(),
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
                    "Go to Challenge Category",
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
