import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class LineFollowerMSPage extends StatefulWidget {
  const LineFollowerMSPage({super.key});

  @override
  State<LineFollowerMSPage> createState() => _LineFollowerMSPageState();
}

class _LineFollowerMSPageState extends State<LineFollowerMSPage> {
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
      const range =
          'LineFollower!A3:D16'; // Updated to include Team Name column

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
      appBar: AppBar(title: const Text("Line Follower MS Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty)
      return const Center(child: Text("No data available"));

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
      DataColumn(
          label:
              Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
        label:
            Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      );
    }).toList();
  }
}

class LineFollowerHSPage extends StatefulWidget {
  const LineFollowerHSPage({super.key});

  @override
  State<LineFollowerHSPage> createState() => _LineFollowerHSPageState();
}

class _LineFollowerHSPageState extends State<LineFollowerHSPage> {
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
      const range = 'LineFollower!F3:I16'; // Updated range for HS

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
      appBar: AppBar(title: const Text("Line Follower HS Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty)
      return const Center(child: Text("No data available"));

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
      DataColumn(
          label:
              Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
        label:
            Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      );
    }).toList();
  }
}

class LineFollowerESPage extends StatefulWidget {
  const LineFollowerESPage({super.key});

  @override
  State<LineFollowerESPage> createState() => _LineFollowerESPageState();
}

class _LineFollowerESPageState extends State<LineFollowerESPage> {
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
      const range = 'LineFollower!K3:N16'; // Updated range for ES

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
      appBar: AppBar(title: const Text("Line Follower ES Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty)
      return const Center(child: Text("No data available"));

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
      DataColumn(
          label:
              Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
        label:
            Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      );
    }).toList();
  }
}
