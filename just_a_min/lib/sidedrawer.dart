import 'package:flutter/material.dart';
import 'sidedrawer_options/doctortap.dart';
import 'sidedrawer_options/hospitaltap.dart';
import 'sidedrawer_options/pharmacytap.dart';

class MyDrawer_Page extends StatefulWidget {
  @override
  _MyDrawer_PageState createState() => _MyDrawer_PageState();
}

class _MyDrawer_PageState extends State<MyDrawer_Page> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'App Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.local_pharmacy),
              title: Text('Pharmacy'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PharmacyTap_Page()),
                );
              }),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Hospitals'),
            onTap: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalTap_Page()),
                );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Doctors'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorTap_Page()),
                );
            },
          ),
        ],
      ),
    );
  }
}
