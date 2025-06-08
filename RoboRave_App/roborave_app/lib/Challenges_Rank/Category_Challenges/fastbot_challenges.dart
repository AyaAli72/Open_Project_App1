import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class FastbotMSPage extends StatefulWidget {
  const FastbotMSPage({super.key});

  @override
  State<FastbotMSPage> createState() => _FastbotMSPageState();
}

class _FastbotMSPageState extends State<FastbotMSPage> {
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
          'Fastbot!A3:D16'; // Changed from 'FastBot' to 'Fastbot' for consistency

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
      appBar: AppBar(title: const Text("Fastbot MS Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
          label: Text('Team', style: TextStyle(fontWeight: FontWeight.bold))),
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
    return sheetData
        .where((row) => row.isNotEmpty && row.length >= 4)
        .map((row) {
      return DataRow(
        cells: [
          DataCell(Text(row[0])),
          DataCell(Text(row[1])),
          DataCell(Text(row[2])),
        ],
      );
    }).toList();
  }
}

class FastbotHSPage extends StatefulWidget {
  const FastbotHSPage({super.key});

  @override
  State<FastbotHSPage> createState() => _FastbotHSPageState();
}

class _FastbotHSPageState extends State<FastbotHSPage> {
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
      const range = 'Fastbot!F3:I16'; // Changed from 'FastBot' to 'Fastbot'

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
      appBar: AppBar(title: const Text("Fastbot HS Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
          label: Text('Team', style: TextStyle(fontWeight: FontWeight.bold))),
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
    return sheetData
        .where((row) => row.isNotEmpty && row.length >= 4)
        .map((row) {
      return DataRow(
        cells: [
          DataCell(Text(row[0])),
          DataCell(Text(row[1])),
          DataCell(Text(row[2])),
        ],
      );
    }).toList();
  }
}

class FastbotESPage extends StatefulWidget {
  const FastbotESPage({super.key});

  @override
  State<FastbotESPage> createState() => _FastbotESPageState();
}

class _FastbotESPageState extends State<FastbotESPage> {
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
      const range = 'Fastbot!K3:N16'; // Changed from 'FastBot' to 'Fastbot'

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
      appBar: AppBar(title: const Text("Fastbot ES Challenge")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return _buildDataTable();
  }

  Widget _buildDataTable() {
    if (sheetData.isEmpty) {
      return const Center(child: Text("No data available"));
    }

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
    return sheetData
        .where((row) => row.isNotEmpty && row.length >= 4)
        .map((row) {
      return DataRow(
        cells: [
          DataCell(Text(row[0])),
          DataCell(Text(row[1])),
          DataCell(Text(row[2])),
        ],
      );
    }).toList();
  }
}
