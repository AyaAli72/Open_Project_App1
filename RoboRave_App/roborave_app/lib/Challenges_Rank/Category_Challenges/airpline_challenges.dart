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
      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      const range = 'Airpline!A2:C21';

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
      body: Column(
        children: [
          Center(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : _buildDataTable(),
          ),
        ],
      ),
    );
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
    if (sheetData.isEmpty) return [];

    return sheetData[0].asMap().entries.map((entry) {
      final index = entry.key;
      return DataColumn(
        label: Text(
          index == 0
              ? 'Team'
              : index == 1
                  ? 'Rank'
                  : 'Round',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        numeric: index > 0,
      );
    }).toList();
  }

  List<DataRow> _buildRows() {
    if (sheetData.length <= 1) return [];

    return sheetData.sublist(1).where((row) => row.isNotEmpty).map((row) {
      return DataRow(
        cells: row.map((cell) {
          return DataCell(Text(cell));
        }).toList(),
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
      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      const range = 'Airpline!E2:G21';

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
      body: Column(
        children: [
          Center(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : _buildDataTable(),
          ),
        ],
      ),
    );
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
    if (sheetData.isEmpty) return [];

    return sheetData[0].asMap().entries.map((entry) {
      final index = entry.key;
      return DataColumn(
        label: Text(
          index == 0
              ? 'Team'
              : index == 1
                  ? 'Rank'
                  : 'Round',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        numeric: index > 0,
      );
    }).toList();
  }

  List<DataRow> _buildRows() {
    if (sheetData.length <= 1) return [];

    return sheetData.sublist(1).where((row) => row.isNotEmpty).map((row) {
      return DataRow(
        cells: row.map((cell) {
          return DataCell(Text(cell));
        }).toList(),
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
      const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
      const range = 'Airpline!I2:K21';

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
      body: Column(
        children: [
          Center(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : _buildDataTable(),
          ),
        ],
      ),
    );
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
    if (sheetData.isEmpty) return [];

    return sheetData[0].asMap().entries.map((entry) {
      final index = entry.key;
      return DataColumn(
        label: Text(
          index == 0
              ? 'Team'
              : index == 1
                  ? 'Rank'
                  : 'Round',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        numeric: index > 0,
      );
    }).toList();
  }

  List<DataRow> _buildRows() {
    if (sheetData.length <= 1) return [];

    return sheetData.sublist(1).where((row) => row.isNotEmpty).map((row) {
      return DataRow(
        cells: row.map((cell) {
          return DataCell(Text(cell));
        }).toList(),
      );
    }).toList();
  }
}
