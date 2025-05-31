import 'package:flutter/material.dart';
import 'googlesheetAPI.dart';
import 'addmaterial.dart';
import 'slidedrawer.dart';
import 'Screens/Splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '0 Waste Hub App!!',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MaterialItem> _allMaterials = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSheetData();
  }

  Future<void> _fetchSheetData() async {
    try {
      final data = await GoogleSheetsApi.getData(
        spreadsheetId: '1N2gYaGOuN-VdU4EznQrx0jkCkbKJ9QZ2JZphSVDGHVA',
        range: 'Material!A2:E', // Reduced to 5 columns
      );

      setState(() {
        _allMaterials = _parseSheetData(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  List<MaterialItem> _parseSheetData(List<List<String>> data) {
    if (data.isEmpty) return [];

    final rows = data.length > 1 ? data.sublist(1) : [];

    return rows.map((row) {
      // Create a mutable copy and ensure at least 4 columns
      List<String> rowData = List.from(row);
      if (rowData.length < 4) {
        rowData.addAll(List.filled(4 - rowData.length, ''));
      }

      // Parse name
      String name = rowData[0].isNotEmpty ? rowData[0] : 'Unnamed Material';

      // Parse price - clean any non-numeric characters
      double price = 0.0;
      if (rowData[1].isNotEmpty) {
        final cleanPrice = rowData[1].replaceAll(RegExp(r'[^0-9.]'), '');
        price = double.tryParse(cleanPrice) ?? 0.0;
      }

      // Parse amount - clean any non-numeric characters
      int amount = 0;
      if (rowData[2].isNotEmpty) {
        final cleanAmount = rowData[2].replaceAll(RegExp(r'[^0-9]'), '');
        amount = int.tryParse(cleanAmount) ?? 0;
      }

      // Parse details
      String details = rowData.length > 3 ? rowData[3] : '';

      return MaterialItem(
        name: name,
        price: price,
        amount: amount,
        details: details,
      );
    }).toList();
  }

  Widget _buildMaterialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Available Materials',
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 220,
          child: _allMaterials.isEmpty
              ? Center(child: Text('No materials available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _allMaterials.length,
                  itemBuilder: (context, index) {
                    final material = _allMaterials[index];
                    return Container(
                      width: 180,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Material name
                              Text(
                                material.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green[800],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),

                              // Price
                              _buildInfoRow(
                                  'Price',
                                  '\$${material.price.toStringAsFixed(2)}/kg',
                                  Colors.green),

                              // Amount
                              _buildInfoRow('Amount Available',
                                  '${material.amount} kg', Colors.blue),

                              // Details
                              if (material.details.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Details:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  material.details,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "0 Waste Hub",
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MyDrawer_Page(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMaterialList(),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        backgroundColor: Colors.green[800],
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMaterialPage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.add, size: 30),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class MaterialItem {
  final String name;
  final double price;
  final int amount;
  final String details;

  MaterialItem({
    required this.name,
    required this.price,
    required this.amount,
    required this.details,
  });
}
