import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class SumoCupPage extends StatefulWidget {
  const SumoCupPage({super.key});

  @override
  State<SumoCupPage> createState() => _SumoCupPageState();
}

class _SumoCupPageState extends State<SumoCupPage> {
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
      const range = 'SumoCup!A3:C21'; // Read multiple rows

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
        appBar: AppBar(title: const Text("Sumo Cup Challenge")),
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
        ));
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
                  : 'Round ',
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
