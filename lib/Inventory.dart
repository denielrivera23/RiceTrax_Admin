import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'RiceStock.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final List<Map<String, dynamic>> riceData = [
    {'name': 'Dinorado', 'stock': 50},
    {'name': 'Sinandomeng', 'stock': 30},
    {'name': 'Jasmine', 'stock': 20},
    {'name': 'Well-Milled', 'stock': 45},
    {'name': 'Premium', 'stock': 60},
    {'name': 'Brown Rice', 'stock': 25},
    {'name': 'Red Rice', 'stock': 15},
    {'name': 'Glutinous', 'stock': 10},
    {'name': 'Extra Brand', 'stock': 5},
  ];

  String getStatus(int stock) {
    if (stock <= 10) return 'Out of Stock';
    if (stock <= 25) return 'Low Stock';
    return 'In Stock';
  }

  Color getBadgeColor(String status) {
    switch (status) {
      case 'In Stock':
        return Colors.green.shade200;
      case 'Low Stock':
        return Colors.yellow.shade600;
      case 'Out of Stock':
        return Colors.red.shade300;
      default:
        return Colors.grey;
    }
  }

  Icon getIcon() {
    return Icon(Icons.warehouse, color: Colors.green[800], size: 28);
  }

  void _showDeleteConfirmation(BuildContext context, String brandName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete "$brandName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // cancel
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                riceData.removeWhere((item) => item['name'] == brandName);
              });
              Navigator.of(context).pop(); // close the dialog
              // Optionally, show a Snackbar for confirmation
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$brandName deleted successfully!'),
                duration: Duration(seconds: 2),
              ));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.green[800],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green[900]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('RiceTrax', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
              }),
              _buildDrawerItem(icon: Icons.inventory, title: 'Rice Inventory Stock', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RiceStock()));
              }),
              _buildDrawerItem(icon: Icons.list_alt, title: 'Inventory', context: context),
              _buildDrawerItem(icon: Icons.attach_money, title: 'Sales', context: context),
              _buildDrawerItem(icon: Icons.notifications, title: 'Notifications', context: context),
              _buildDrawerItem(icon: Icons.settings, title: 'Settings', context: context),
              _buildDrawerItem(icon: Icons.logout, title: 'Logout', context: context),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inventory', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: riceData.length,
                itemBuilder: (context, index) {
                  final item = riceData[index];
                  final status = getStatus(item['stock']);
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RiceDetailsPage(brandName: item['name']),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: getIcon(),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('${item['stock']} sacks', style: TextStyle(fontSize: 14)),
                                  SizedBox(height: 8), // Fixed height here
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: getBadgeColor(status),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.edit, color: Colors.grey),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDeleteConfirmation(context, item['name']);
                              },
                              icon: Icon(Icons.delete, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.green),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('+ Add Brand', style: TextStyle(fontSize: 16, color: Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }
}

class RiceDetailsPage extends StatelessWidget {
  final String brandName;

  const RiceDetailsPage({Key? key, required this.brandName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riceDetails = {
      'Dinorado': {
        'stock': 150,
        'sold': 90,
        'price': 1800,
        'transactions': [
          {'id': 'T001', 'date': '2025-05-01', 'qty': 20, 'price': 45},
          {'id': 'T002', 'date': '2025-05-03', 'qty': 15, 'price': 45},
          {'id': 'T003', 'date': '2025-05-10', 'qty': 5, 'price': 45},
        ],
      },
      'Sinandomeng': {
        'stock': 80,
        'sold': 40,
        'price': 1750,
        'transactions': [
          {'id': 'S001', 'date': '2025-05-01', 'qty': 10, 'price': 45},
          {'id': 'S002', 'date': '2025-05-06', 'qty': 15, 'price': 45},
        ],
      },
      'Jasmine': {
        'stock': 60,
        'sold': 20,
        'price': 1900,
        'transactions': [
          {'id': 'J001', 'date': '2025-05-03', 'qty': 10, 'price': 47},
        ],
      },
      'Well-Milled': {
        'stock': 60,
        'sold': 20,
        'price': 1300,
        'transactions': [
          {'id': 'J001', 'date': '2025-05-03', 'qty': 10, 'price': 47},
        ],
      },
      'Premium': {
        'stock': 60,
        'sold': 20,
        'price': 1120,
        'transactions': [
          {'id': 'J001', 'date': '2025-05-03', 'qty': 10, 'price': 47},
        ],
      },
      'Brown Rice': {
        'stock': 60,
        'sold': 20,
        'price': 1200,
        'transactions': [
          {'id': 'J001', 'date': '2025-05-03', 'qty': 10, 'price': 47},
        ],
      },
    };

    final details = riceDetails[brandName];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('$brandName Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: details == null
          ? Center(child: Text('No data available for $brandName'))
          : Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildInfoCard('Total Stock', '${details['stock']} sacks', Colors.green),
                  _buildInfoCard('Sold Stock', '${details['sold']} sacks', Colors.orange),
                  _buildInfoCard('Price/Sack', '₱${details['price']}', Colors.blue),
                ],
              ),
              SizedBox(height: 20),
              Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FixedColumnWidth(130),
                    1: FixedColumnWidth(120),
                    2: FixedColumnWidth(90),
                    3: FixedColumnWidth(100),
                    4: FixedColumnWidth(110),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.green[100]),
                      children: const [
                        Padding(padding: EdgeInsets.all(12), child: Text('Transaction ID', style: TextStyle(fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.all(12), child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.all(12), child: Text('Qty (kg)', style: TextStyle(fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.all(12), child: Text('Unit Price', style: TextStyle(fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.all(12), child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    ...List<TableRow>.from((details['transactions'] as List).map((txn) {
                      final total = txn['qty'] * txn['price'];
                      return TableRow(
                        children: [
                          Padding(padding: EdgeInsets.all(12), child: Text(txn['id'])),
                          Padding(padding: EdgeInsets.all(12), child: Text(txn['date'])),
                          Padding(padding: EdgeInsets.all(12), child: Text('${txn['qty']}')),
                          Padding(padding: EdgeInsets.all(12), child: Text('₱${txn['price']}')),
                          Padding(padding: EdgeInsets.all(12), child: Text('₱${total.toStringAsFixed(2)}')),
                        ],
                      );
                    })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, Color color) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
