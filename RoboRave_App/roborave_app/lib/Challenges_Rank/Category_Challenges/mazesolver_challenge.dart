import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class MazeSolverMSPage extends StatefulWidget {
  const MazeSolverMSPage({super.key});

  @override
  State<MazeSolverMSPage> createState() => _MazeSolverMSPageState();
}

class _MazeSolverMSPageState extends State<MazeSolverMSPage> {
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
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      
      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      const range = 'MazeSolver!A2:D21'; // Updated to 4 columns

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
      appBar: AppBar(title: const Text("Maze Solver MS Challenge")), // Fixed title spacing
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty) return const Center(child: Text("No data available"));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _buildColumns(),
        rows: _buildRows(),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return const [
      DataColumn(label: Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
        label: Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
      DataColumn(
        label: Text('Round', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return sheetData.where((row) => row.length >= 4).map((row) {
      return DataRow(
        cells: [
          DataCell(Text(row[0].toString())),
          DataCell(Text(row[1].toString())),
          DataCell(Text(row[2].toString())),
          DataCell(Text(row[3].toString())),
        ],
      );
    }).toList();
  }
}

class MazeSolverESPage extends StatefulWidget {
  const MazeSolverESPage({super.key});

  @override
  State<MazeSolverESPage> createState() => _MazeSolverESPageState();
}

class _MazeSolverESPageState extends State<MazeSolverESPage> {
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
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      
      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      const range = 'MazeSolver!F2:I21'; // Updated to 4 columns

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
      appBar: AppBar(title: const Text("Maze Solver ES Challenge")), // Fixed title
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty) return const Center(child: Text("No data available"));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _buildColumns(),
        rows: _buildRows(),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return const [
      DataColumn(label: Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(label: Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
        label: Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
      DataColumn(
        label: Text('Round', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return sheetData.where((row) => row.length >= 4).map((row) {
      return DataRow(
        cells: [
          DataCell(Text(row[0].toString())),
          DataCell(Text(row[1].toString())),
          DataCell(Text(row[2].toString())),
          DataCell(Text(row[3].toString())),
        ],
      );
    }).toList();
  }
}