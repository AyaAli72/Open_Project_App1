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
        range: 'Material!A3:H', // Added columns for user info
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

    return data.map((row) {
      // Pad row to 8 columns (A-H)
      List<String> rowData = [...row]..addAll(List.filled(8 - row.length, ''));

      // Parse material name
      String name = rowData[0].isNotEmpty ? rowData[0] : 'Unnamed Material';

      // Parse price
      double price = 0.0;
      if (rowData[1].isNotEmpty) {
        final cleanPrice = rowData[1].replaceAll(RegExp(r'[^0-9.]'), '');
        price = double.tryParse(cleanPrice) ?? 0.0;
      }

      // Parse amount
      int amount = 0;
      if (rowData[2].isNotEmpty) {
        final cleanAmount = rowData[2].replaceAll(RegExp(r'[^0-9]'), '');
        amount = int.tryParse(cleanAmount) ?? 0;
      }

      // Parse details
      String details = rowData.length > 3 ? rowData[3] : '';

      // Parse image URL
      String imageUrl = rowData.length > 4 ? rowData[4] : '';

      // Parse user info
      String userName = rowData.length > 5 ? rowData[5] : 'No Name';
      String userAddress = rowData.length > 6 ? rowData[6] : 'No Address';
      String userPhone = rowData.length > 7 ? rowData[7] : 'No Phone';

      return MaterialItem(
        name: name,
        price: price,
        amount: amount,
        details: details,
        imageUrl: imageUrl,
        userName: userName,
        userAddress: userAddress,
        userPhone: userPhone,
      );
    }).toList();
  }

  Widget _buildMaterialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Available Materials',
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 250, // Increased height to accommodate new info
          child: _allMaterials.isEmpty
              ? Center(child: Text('No materials available'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _allMaterials.length,
                  itemBuilder: (context, index) {
                    final material = _allMaterials[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MaterialDetailPage(material: material),
                          ),
                        );
                      },
                      child: Container(
                        width: 200, // Slightly wider to fit new info
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
                                _buildInfoRow('Available',
                                    '${material.amount} kg', Colors.blue),

                                // User information section
                                Divider(color: Colors.grey[300], thickness: 1),

                                // User name
                                _buildUserInfoRow(
                                  Icons.person,
                                  material.userName,
                                  Colors.purple,
                                ),

                                // User address
                                _buildUserInfoRow(
                                  Icons.location_on,
                                  material.userAddress,
                                  Colors.orange,
                                ),

                                // User phone
                                _buildUserInfoRow(
                                  Icons.phone,
                                  material.userPhone,
                                  Colors.blue,
                                ),
                              ],
                            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildUserInfoRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                          ).then((_) => _fetchSheetData());
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
  final String imageUrl;
  final String userName;
  final String userAddress;
  final String userPhone;

  MaterialItem({
    required this.name,
    required this.price,
    required this.amount,
    required this.details,
    required this.imageUrl,
    required this.userName,
    required this.userAddress,
    required this.userPhone,
  });
}

class MaterialDetailPage extends StatelessWidget {
  final MaterialItem material;

  const MaterialDetailPage({Key? key, required this.material})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          material.name,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Material Name
            _buildDetailSection(
              title: "Material",
              content: material.name,
              icon: Icons.inventory,
              iconColor: Colors.green,
            ),

            const SizedBox(height: 20),

            // Material Price
            _buildDetailSection(
              title: "Price",
              content: "\$${material.price.toStringAsFixed(2)} per kg",
              icon: Icons.attach_money,
              iconColor: Colors.green,
            ),

            const SizedBox(height: 20),

            // Material Amount
            _buildDetailSection(
              title: "Available Amount",
              content: "${material.amount} kg",
              icon: Icons.scale,
              iconColor: Colors.blue,
            ),

            const SizedBox(height: 20),

            // User Information Section
            _buildUserInfoSection(),

            const SizedBox(height: 20),

            // Material Details
            _buildDetailSection(
              title: "Details",
              content: material.details.isNotEmpty
                  ? material.details
                  : "No details provided",
              icon: Icons.description,
              iconColor: Colors.grey,
            ),

            const SizedBox(height: 20),

            // Image Section
            if (material.imageUrl.isNotEmpty) _buildImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, color: Colors.purple, size: 28),
            const SizedBox(width: 10),
            const Text(
              "User Information",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Name
              _buildUserDetailRow("Name", material.userName),

              const SizedBox(height: 10),

              // User Address
              _buildUserDetailRow("Address", material.userAddress),

              const SizedBox(height: 10),

              // User Phone
              _buildUserDetailRow("Phone", material.userPhone),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.image, color: Colors.purple, size: 28),
            const SizedBox(width: 10),
            const Text(
              "Image",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display image if URL is valid
              if (Uri.tryParse(material.imageUrl)?.hasAbsolutePath ?? false)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(material.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Invalid image URL",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              // Show URL text
              SelectableText(
                material.imageUrl,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
