import 'package:flutter/material.dart';

class ASDPage extends StatefulWidget {
  @override
  _ASDPageState createState() => _ASDPageState();
}

class _ASDPageState extends State<ASDPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Helping ASD Page',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildSection(title: 'LearningCourses'),
            const SizedBox(height: 20),
            _buildSection(title: 'Therapists Data'),
            const SizedBox(height: 20),
            _buildSection(title: 'Therapists Sessions'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title}) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
