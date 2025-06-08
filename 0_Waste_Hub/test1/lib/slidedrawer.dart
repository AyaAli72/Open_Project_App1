import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'googlesheetAPI.dart';
import 'Company.dart';
import 'personal_user.dart';

class MyDrawer_Page extends StatefulWidget {
  @override
  _MyDrawer_PageState createState() => _MyDrawer_PageState();
}

class _MyDrawer_PageState extends State<MyDrawer_Page> {
  List<String> _userNames = [];
  List<String> _companyNames = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      const spreadsheetId = '1N2gYaGOuN-VdU4EznQrx0jkCkbKJ9QZ2JZphSVDGHVA';

      // Load users from SignIn sheet
      const usersRange = 'PersonalUser!A2:E';
      final usersData = await GoogleSheetsApi.getData(
        spreadsheetId: spreadsheetId,
        range: usersRange,
      );

      // Load companies from Company sheet
      const companiesRange = 'Company!A2:D'; // Adjust range as needed
      final companiesData = await GoogleSheetsApi.getData(
        spreadsheetId: spreadsheetId,
        range: companiesRange,
      );

      setState(() {
        _userNames = usersData
            .where((row) => row.isNotEmpty && row[0].toString().isNotEmpty)
            .map((row) => row[0].toString())
            .toList();

        _companyNames = companiesData
            .where((row) => row.isNotEmpty && row[0].toString().isNotEmpty)
            .map((row) => row[0].toString())
            .toList();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color.fromARGB(255, 24, 23, 23),
                    child: Icon(Icons.person,
                        size: 40, color: Color.fromARGB(255, 4, 125, 79)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Users section
          ExpansionTile(
            leading: Icon(Icons.group, color: Colors.green),
            title: Text('User List', style: TextStyle(fontSize: 18)),
            children: [
              if (_isLoading)
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ))
              else if (_errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)),
                )
              else if (_userNames.isEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No users found'),
                )
              else
                ..._userNames
                    .map((name) => ListTile(
                          title: Text(
                            name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ))
                    .toList(),
            ],
          ),

          // Companies section
          ExpansionTile(
            leading: Icon(Icons.business, color: Colors.green),
            title: Text('Company List', style: TextStyle(fontSize: 18)),
            children: [
              if (_isLoading)
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ))
              else if (_errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)),
                )
              else if (_companyNames.isEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No companies found'),
                )
              else
                ..._companyNames
                    .map((company) => ListTile(
                          title: Text(
                            company,
                            style: TextStyle(fontSize: 16),
                          ),
                        ))
                    .toList(),
            ],
          ),

          // Navigation items
          ListTile(
            leading: Icon(Icons.business, color: Colors.green),
            title: Text('Company', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompanyPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.green),
            title: Text('Personal User', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonalUserPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.green),
            title: Text('Profile Page', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilPage()));
            },
          ),
          Divider(),

          // Additional drawer items
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green),
            title: Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.help, color: Colors.green),
            title: Text('Help & Support', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.green),
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
