import 'package:flutter/material.dart';
import 'dart:developer';
import 'googlesheetapi.dart'; // Make sure this file exists or comment out if not used

void main() {
  runApp(MaterialApp(
    home: ChallengeResultPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ChallengeResultPage extends StatefulWidget {
  @override
  _ChallengeResultPageState createState() => _ChallengeResultPageState();
}

class _ChallengeResultPageState extends State<ChallengeResultPage> {
  String selectedOption = 'Sumo Cup';

  void navigateBasedOnSelection(String value) {
    Widget page;
    switch (value) {
      case 'Maze Solver':
        page = MazeSolverPage();
        break;
      case 'Fire Fighter':
        page = FireFighterPage();
        break;
      case 'Line Follower':
        page = LineFollowerPage();
        break;
      case 'Airpline':
        page = AirplinePage();
        break;
      case 'Fastbot':
        page = FastbotPage();
        break;
      case 'Preshcool':
        page = PreschoolPage();
        break;
      case 'Enterpreneurs(open project)':
        page = EnterpreneursPage();
        break;
      case 'Sumo Cup':
      default:
        page = SumoCupPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Uncomment to fetch Google Sheet Data
  /*
 
  */

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
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  items: <String>[
                    'Sumo Cup',
                    'Maze Solver',
                    'Fire Fighter',
                    'Line Follower',
                    'Airpline',
                    'Fastbot',
                    'Preshcool',
                    'Enterpreneurs(open project)'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => navigateBasedOnSelection(selectedOption),
                  child: const Text(
                    "Go to Challenge Ranke",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 160, 27, 17),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 30),
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
  @override
  _SumoCupPageState createState() => _SumoCupPageState();
}

class _SumoCupPageState extends State<SumoCupPage> {
  dynamic response;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGoogleSheetData();
  }

  Future<void> fetchGoogleSheetData() async {
    try {
      response = await GoogleSheetsApiData(
              clientEmail:
                  "roborave-app-sheet@custom-healer-457718-a5.iam.gserviceaccount.com",
              clientId: "115066501718794913377",
              privateKey:
                  '\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrD3yisNQ8I1td\nRI8OJ0hyHjpZFbwVPcyFlZKnpqW0YRGKa/yenWcjTKJSSpRgl7Nruo27O6Jw+14I\nZUWbvUEW2iy8vfqBRdyPH+JBn3yxFKaiw5EPw3QWBP2cbxzNHlbCAO/lW9hKXvjY\ns6SajHhTFuR+Lvf/Wfbj+Tj0mnZ//YqRHgvex5DwtxYgiDvqffv0wylW+wcbVJgc\neBQwOBc7EBVjhCvAMO+b32B70XP6ssZiMPedY86xIqZX4B94iGBSuTJEG/B76qFv\n/rSrr1puqruHoSp0Y+NUjFEEcIW9ICuD8+dQYuyn6jga9Y/86e3C4ZTujj5yXMmf\nAFTKSETfAgMBAAECggEAFYdFcFRA4bCxdvOB7Y4UGAil30BVA3dbnhRM+LyIbkMp\nKfqdOHkm2dJzO1gXhHCTLCO2YrIGp6F7HCNit08COhYLO1XNiSd5sqmYmBmyX7bx\nodprD0jR+1N1d5KkVUxULuZfSsZcWj/Jobw6Ixk6q3peF2Nh4sk3wUlEWcR21XSm\nKpsPetqmYW5D7pcLh+sG4IR06XbK+nqABi8x12yOoU7A0BZE43AJJ4PEcCDWitu0\n719YrHTYH9ntMsbb2UT7sslRNvohwJ36TjXvsRJB9ARgUhjwV1/AiWNRm4A0Cxjb\nmFnyl8UeV673qdbhi2VBygSSE3yjXRT0xHDrYdhkAQKBgQDvurlvUwIYEqIVQmZ0\nKmyRvMoFSwBwlOxnobVUZF8F28mVdoJwk8yzgKf7m0167EPVO9gHYgL3+5k2ZnmH\nNjyWFmhzpsyQlzpOvsCZlioCd+R3gbq8YifjmNeJcQplQ2gi6wc1qO3iLAN5xT9k\nAeZg8Tlu6s0069JFkNBpiWi5HwKBgQC2q6WaIK/U3HKyAUxsKKXv8ZmfxBq6vN0P\n7j7mU3iJ3X6M36B9ipf8zZfccB51V11RpNlPNrzRGcmXRvByBDHP9Cbn0tbs2Aig\nxxXyJRp6x6YZnFUY5MrGlpbj6z3qfcm0Iw6eutVw4kkXc04HKTxAHbA3JVCXgFLW\nsmMTJPI8QQKBgQCJ3B93XYz+uvhqsVypwRveU2r50D/YfkvU7LGSboYWoGY0hYpN\nozE8qOfxUUYlQmlf3qJE3KBIa2+YUSXiE9aTmR9IIsvQ+qaVUi0AJdLSyI+iCgCR\nBQFbaTHJ4C/SPAlOy0nCGfty7UyyYjQqFs2dQht9JZoMrPCnALhZeKO4kQKBgFeD\n6LTs0BClBPYvFRQEbWuFTlpys3OfpDFLrSrf9rHmQgjv4o4C5kohnY3o0U7aakUB\nO3NuAAwV1LT7MZsOU2cTy8fpBTs3TPrqJqN6DzOfjv5aHZLtmhCGeQf83g8H8Kiy\n2wBE9pk8cFQh09IueUUmdBQXdoL+4bEmibzUSJGBAoGAYmWoyubwxtk9ZenNlzca\nrVJLNWvGqC0dIcgGWgUnkl4yfhldOcXNV25/aO2q8nM0FapIAN7CSlSNccW9kqMt\nTYH7EmrUbei3PW4Y2kadG11gIFfyz1iv+Hpa2qFdlbSP2g7xuQvWnGC3JO5Wo7kh\nkHvh5tq5esK4d9hhEk8z4hQ=\n',
              url: "1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic")
          .accessGoogleSheetData();

      log("response: $response");
    } catch (e) {
      log("Error fetching sheet data: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sumo Cup Challenge")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : response != null
                ? Text(response.toString())
                : const Text("No data available"),
      ),
    );
  }
}

class MazeSolverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Maze Solver Challenge");
  }
}

class FireFighterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Fire Fighter Challenge");
  }
}

class LineFollowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Line Follower Challenge");
  }
}

class AirplinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Airpline Challenge");
  }
}

class FastbotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Fastbot Challenge");
  }
}

class PreschoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Preschool Challenge");
  }
}

class EnterpreneursPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage("Enterpreneurs Challenge");
  }
}

// Helper function to build pages
Widget _buildPage(String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text("This is the $title page.")),
  );
}
