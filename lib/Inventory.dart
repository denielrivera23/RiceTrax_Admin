import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'RiceStock.dart';

class Inventory extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'name': 'Dinorado', 'sacks': 50},
    {'name': 'Sinandomeng', 'sacks': 30},
    {'name': 'Jasmine', 'sacks': 20},
    {'name': 'Well-milled', 'sacks': 45},
    {'name': 'Premium', 'sacks': 60},
    {'name': 'Brown Rice', 'sacks': 25},
    {'name': 'Red Rice', 'sacks': 15},
    {'name': 'Glutinous', 'sacks': 10},
    {'name': 'Extra Brand', 'sacks': 5},
  ];

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
                    Text(
                      'RiceTrax',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.dashboard,
                title: 'Dashboard',
                context: context,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                ),
              ),
              _buildDrawerItem(
                icon: Icons.inventory,
                title: 'Rice Inventory Stock',
                context: context,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RiceStock()),
                ),
              ),
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
        title: Text(
          'RiceTrax',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              'Inventory',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 16),
          ...items.map((item) => _buildInventoryCard(item['name'], item['sacks'])).toList(),
          SizedBox(height: 24),
        ],
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
      onTap: onTap ?? () {},
    );
  }

  Widget _buildInventoryCard(String title, int sacks) {
    String status;

    if (sacks >= 30) {
      status = 'In Stock';
    } else if (sacks >= 10) {
      status = 'Low Stock';
    } else {
      status = 'Out of Stock';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.rice_bowl, color: Colors.black, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$sacks sacks',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: const Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  print('Edit tapped for $title');
                  // TODO: Implement edit functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: const Color.fromARGB(255, 0, 0, 0)),
                onPressed: () {
                  print('Delete tapped for $title');
                  // TODO: Implement delete functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
