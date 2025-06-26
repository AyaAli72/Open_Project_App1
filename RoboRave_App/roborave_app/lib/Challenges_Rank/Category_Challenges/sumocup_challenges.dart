import 'package:flutter/material.dart';
import '/googlesheetapi.dart';

class SumoCupMSPage extends StatefulWidget {
  const SumoCupMSPage({super.key});

  @override
  State<SumoCupMSPage> createState() => _SumoCupMSPageState();
}

class _SumoCupMSPageState extends State<SumoCupMSPage> {
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
      const range = 'SumoCup!A3:D16';

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
      appBar: AppBar(title: const Text("Sumo Cup 1 KG Challenge")),
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
        label: Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
      DataColumn(
        label:
            Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return sheetData.where((row) => row.length >= 3).map((row) {
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

class SumoCupHSPage extends StatefulWidget {
  const SumoCupHSPage({super.key});

  @override
  State<SumoCupHSPage> createState() => _SumoCupHSPageState();
}

class _SumoCupHSPageState extends State<SumoCupHSPage> {
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
      const range = 'SumoCup!F3:I16';

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
      appBar: AppBar(title: const Text("Sumo Cup 1.5 KG Challenge")),
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
        label: Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
      DataColumn(
        label:
            Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
        numeric: true,
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return sheetData.where((row) => row.length >= 3).map((row) {
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

// class SumoCupUPPage extends StatefulWidget {
//   const SumoCupUPPage({super.key});

//   @override
//   State<SumoCupUPPage> createState() => _SumoCupUPPageState();
// }

// class _SumoCupUPPageState extends State<SumoCupUPPage> {
//   List<List<String>> sheetData = [];
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchSheetData();
//   }

//   Future<void> _fetchSheetData() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = '';
//       });

//       const spreadsheetId = '1T7ZFHehD9cv6nxvqYxAKVL4QlYM512gYCnKj9EbkCic';
//       const range = 'SumoCup!K3:N16';

//       final data = await GoogleSheetsApi.getSheetData(spreadsheetId, range);
//       setState(() {
//         sheetData = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error loading data: $e';
//         isLoading = false;
//       });
//     }
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Sumo Cup UP Challenge")),
  //     body: _buildBody(),
  //   );
  // }

  // Widget _buildBody() {
  //   if (isLoading) return const Center(child: CircularProgressIndicator());
  //   if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
  //   return _buildDataTable();
  // }

  // Widget _buildDataTable() {
  //   if (sheetData.isEmpty)
  //     return const Center(child: Text("No data available"));

  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: DataTable(
  //       columns: _buildColumns(),
  //       rows: _buildRows(),
  //     ),
  //   );
  // }

  // List<DataColumn> _buildColumns() {
  //   return const [
  //     DataColumn(
  //         label:
  //             Text('Team Code', style: TextStyle(fontWeight: FontWeight.bold))),
  //     DataColumn(
  //       label: Text('Team Name', style: TextStyle(fontWeight: FontWeight.bold)),
  //       numeric: true,
  //     ),
  //     DataColumn(
  //       label:
  //           Text('Highest Rank', style: TextStyle(fontWeight: FontWeight.bold)),
  //       numeric: true,
  //     ),
  //   ];
  // }

  // List<DataRow> _buildRows() {
  //   return sheetData.where((row) => row.length >= 3).map((row) {
  //     return DataRow(
  //       cells: [
  //         DataCell(Text(row[0].toString())),
  //         DataCell(Text(row[1].toString())),
  //         DataCell(Text(row[2].toString())),
  //       ],
  //     );
  //   }).toList();
  // }
// }
