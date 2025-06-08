import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class PreschoolWispyPage extends StatefulWidget {
  const PreschoolWispyPage({super.key});

  @override
  State<PreschoolWispyPage> createState() => _PreschoolWispyPageState();
}

class _PreschoolWispyPageState extends State<PreschoolWispyPage> {
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
      const range = 'Preschool!A3:D16'; // Updated to 4 columns

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
      appBar: AppBar(
          title:
              const Text("Preschool Wispy Challenge")), // Fixed title spacing
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

class PreschoolMazesolverPage extends StatefulWidget {
  const PreschoolMazesolverPage({super.key});

  @override
  State<PreschoolMazesolverPage> createState() =>
      _PreschoolMazesolverPageState();
}

class _PreschoolMazesolverPageState extends State<PreschoolMazesolverPage> {
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
      const range = 'Preschool!F3:I16';

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
      appBar: AppBar(
          title: const Text("PreSchool Maze Solver Challenge")), // Fixed title
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

class PreschoolCleaverBuilderPage extends StatefulWidget {
  const PreschoolCleaverBuilderPage({super.key});

  @override
  State<PreschoolCleaverBuilderPage> createState() =>
      _PreschoolCleaverBuilderPageState();
}

class _PreschoolCleaverBuilderPageState
    extends State<PreschoolCleaverBuilderPage> {
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
      const range = 'Preschool!K3:N16';

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
      appBar: AppBar(
          title:
              const Text("PreSchool Cleaver Builder Challenge")), // Fixed title
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
