import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'googlesheetAPI.dart';

class MyDrawer_Page extends StatefulWidget {
  @override
  _MyDrawer_PageState createState() => _MyDrawer_PageState();
}

class _MyDrawer_PageState extends State<MyDrawer_Page> {
  List<String> _userNames = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      const spreadsheetId =
          '1ImOskhUNZtMarvFbyLM5AHs-yP-CkGtqEBxcn81cRGY'; // Replace with your ID
      const range = 'SignIn!A2:D'; // Match your sheet name and range

      final data = await GoogleSheetsApi.getData(
        spreadsheetId: spreadsheetId,
        range: range,
      );

      setState(() {
        _userNames = data.map((row) => row[0].toString()).toList();
      });
    } catch (e) {
      // setState(() {
      //   _errorMessage = 'Failed to load user data: ${e.toString()}';
      // });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'User List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    if (_userNames.isEmpty) {
      return Center(child: Text('No users found'));
    }

    return ListView.builder(
      itemCount: _userNames.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "Hello",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
