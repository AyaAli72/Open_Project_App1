import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class TeamResultPage extends StatefulWidget {
  @override
  _TeamResultPageState createState() => _TeamResultPageState();
}

class _TeamResultPageState extends State<TeamResultPage> {
  List<List<String>> sheetData = [];
  bool isLoading = true;
  String errorMessage = '';
  List<String> teams_Number = [];
  List<double> teams_score = [];
  List<int> teams_round = [];
  final TextEditingController _teamNumberController = TextEditingController();

  String selectedOption = ''; // Will be initialized in initState

  final List<String> challenges = [
    'Sumo Cup 1 KG',
    'Sumo Cup 1.5 KG',
    'Maze Solver MS',
    'Maze Solver ES',
    'Maze Solver ES Manual',
    'Fire Fighter MS',
    'Fire Fighter HS',
    'Fire Fighter UP',
    'Line Follower MS',
    'Line Follower HS',
    'Line Follower ES',
    'Airpline MS',
    'Airpline HS',
    'Airpline UP',
    'Fastbot MS',
    'Fastbot HS',
    'Fastbot ES',
    'Preshcool Wispy',
    'Preshcool Maze Solver',
    'Preshcool Cleaver Builder',
    'Enterpreneurs MS',
    'Enterpreneurs HS',
    'Enterpreneurs ES',
    'Enterpreneurs UP',
  ];

  final Map<String, String> challengeRanges = {
    'Sumo Cup 1 KG': 'SumoCup!A3:D16',
    'Sumo Cup 1.5 KG': 'SumoCup!F3:I16',
    'Maze Solver MS': 'A_Maze!K3:N16',
    'Maze Solver ES': 'A_Maze!F3:I16',
    'Maze Solver ES Manual': 'A_Maze!A3:D16',
    'Fire Fighter MS': 'FireFighter!A3:D16',
    'Fire Fighter HS': 'FireFighter!F3:I16',
    'Fire Fighter UP': 'FireFighter!K3:N16',
    'Line Follower MS': 'LineFollower!A3:D16',
    'Line Follower HS': 'LineFollower!F3:I16',
    'Line Follower ES': 'LineFollower!K3:N16',
    'Airpline MS': 'Airpline!A3:D16',
    'Airpline HS': 'Airpline!F3:I16',
    'Airpline UP': 'Airpline!K3:N16',
    'Fastbot MS': 'Fastbot!A3:D16',
    'Fastbot HS': 'Fastbot!F3:I16',
    'Fastbot ES': 'Fastbot!K3:N16',
    'Preshcool Wispy': 'Preschool!A3:D16',
    'Preshcool Maze Solver': 'Preschool!F3:I16',
    'Preshcool Cleaver Builder': 'Preschool!K3:N16',
    'Enterpreneurs MS': 'Enterpreneurs!A3:D16',
    'Enterpreneurs HS': 'Enterpreneurs!F3:I16',
    'Enterpreneurs ES': 'Enterpreneurs!K3:N16',
    'Enterpreneurs UP': 'Enterpreneurs!P3:S16',
  };

  @override
  void initState() {
    super.initState();
    selectedOption = challenges.first;
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      final range = challengeRanges[selectedOption] ?? '';
      if (range.isEmpty) {
        throw Exception('No range defined for selected challenge');
      }

      final data = await GoogleSheetsApi.getSheetData(spreadsheetId, range);
      setState(() {
        sheetData = data;
        _storeData();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading data: $e';
        isLoading = false;
      });
    }
  }

  void _storeData() {
    teams_Number.clear();
    teams_score.clear();
    teams_round.clear();

    for (final row in sheetData) {
      if (row.length >= 4) {
        teams_Number.add(row[0].toString());
        teams_score.add(double.tryParse(row[2].toString()) ?? 0.0);
        teams_round.add(int.tryParse(row[3].toString()) ?? 0);
      }
    }
  }

  List<dynamic> returnTeamScore() {
    final teamNumber = _teamNumberController.text.trim();
    if (teamNumber.isEmpty) return [];

    for (int i = 0; i < teams_Number.length; i++) {
      if (teamNumber == teams_Number[i]) {
        return [teams_score[i], teams_round[i]];
      }
    }
    return [];
  }

  @override
  void dispose() {
    _teamNumberController.dispose();
    super.dispose();
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
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != selectedOption) {
                      setState(() {
                        selectedOption = newValue;
                      });
                      _fetchSheetData();
                    }
                  },
                  hint: Text('Select a challenge'),
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
                SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator()
                else if (errorMessage.isNotEmpty)
                  Text(errorMessage, style: TextStyle(color: Colors.red))
                else
                  ElevatedButton(
                    onPressed: () {
                      final result = returnTeamScore();
                      if (result.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Team Results'),
                            content: Text('Highest Score: ${result[0]}}'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              )
                            ],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Team not found or team number is empty')),
                        );
                      }
                    },
                    child: Text(
                      "Get Team Result",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 69, vertical: 30),
                      backgroundColor: const Color.fromARGB(255, 156, 15, 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
