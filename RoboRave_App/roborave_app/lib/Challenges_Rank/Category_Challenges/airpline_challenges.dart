import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class AirplineMSPage extends StatefulWidget {
  const AirplineMSPage({super.key});

  @override
  State<AirplineMSPage> createState() => _AirplineMSPageState();
}

class _AirplineMSPageState extends State<AirplineMSPage> {
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
      const range = 'Airpline!A3:D16'; // Updated to include Team Name column

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
      appBar: AppBar(title: const Text("Airpline MS Challenge")),
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

class AirplineHSPage extends StatefulWidget {
  const AirplineHSPage({super.key});

  @override
  State<AirplineHSPage> createState() => _AirplineHSPageState();
}

class _AirplineHSPageState extends State<AirplineHSPage> {
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
      const range = 'Airpline!F3:I16'; // Updated range for HS

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
      appBar: AppBar(title: const Text("Airpline HS Challenge")),
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

class AirplineUPPage extends StatefulWidget {
  const AirplineUPPage({super.key});

  @override
  State<AirplineUPPage> createState() => _AirplineUPPageState();
}

class _AirplineUPPageState extends State<AirplineUPPage> {
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
      const range = 'Airpline!K3:N16'; // Updated range for UP

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
      appBar: AppBar(title: const Text("Airpline UP Challenge")),
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
