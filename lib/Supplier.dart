import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Inventory.dart';
import 'NotificationsPage.dart';
import 'RiceStock.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  List<Map<String, dynamic>> batchData = [
    {'name': 'Agro Supply Co.', 'product': 'Jasmine Rice', 'quantity': 100, 'date': '2025-07-01', 'cost': 5000.0},
    {'name': 'RiceGrower Inc.', 'product': 'Brown Rice', 'quantity': 200, 'date': '2025-07-08', 'cost': 10200.0},
    {'name': 'Harvest Partners', 'product': 'Basmati Rice', 'quantity': 150, 'date': '2025-07-12', 'cost': 7500.0},
  ];

  void _addNewBatch() {
    final nameController = TextEditingController();
    final productController = TextEditingController();
    final quantityController = TextEditingController();
    final dateController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Add New Batch', style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold)),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(nameController, 'Supplier Name'),
                SizedBox(height: 10),
                _buildInputField(productController, 'Product Name'),
                SizedBox(height: 10),
                _buildInputField(quantityController, 'Quantity (kg)', isNumber: true),
                SizedBox(height: 10),
                _buildDateField(dateController, 'Date Purchased'),
                SizedBox(height: 10),
                _buildInputField(costController, 'Total Cost (₱)', isNumber: true),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              if (nameController.text.isNotEmpty && 
                  productController.text.isNotEmpty &&
                  quantityController.text.isNotEmpty &&
                  dateController.text.isNotEmpty &&
                  costController.text.isNotEmpty) {
                setState(() {
                  batchData.add({
                    'name': nameController.text,
                    'product': productController.text,
                    'quantity': int.tryParse(quantityController.text) ?? 0,
                    'date': dateController.text,
                    'cost': double.tryParse(costController.text) ?? 0.0,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Batch added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill all fields'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text('Save Batch', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _editBatch(int index) {
    final item = batchData[index];
    final nameController = TextEditingController(text: item['name']);
    final productController = TextEditingController(text: item['product']);
    final quantityController = TextEditingController(text: item['quantity'].toString());
    final dateController = TextEditingController(text: item['date']);
    final costController = TextEditingController(text: item['cost'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Edit Batch', style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold)),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(nameController, 'Supplier Name'),
                SizedBox(height: 10),
                _buildInputField(productController, 'Product Name'),
                SizedBox(height: 10),
                _buildInputField(quantityController, 'Quantity (kg)', isNumber: true),
                SizedBox(height: 10),
                _buildDateField(dateController, 'Date Purchased'),
                SizedBox(height: 10),
                _buildInputField(costController, 'Total Cost (₱)', isNumber: true),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                batchData[index] = {
                  'name': nameController.text,
                  'product': productController.text,
                  'quantity': int.tryParse(quantityController.text) ?? 0,
                  'date': dateController.text,
                  'cost': double.tryParse(costController.text) ?? 0.0,
                };
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Batch updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Save Changes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[900]),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[900]),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.green[900]),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          controller.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
        }
      },
    );
  }

  void _deleteBatch(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this batch?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                batchData.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Batch deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required BuildContext context, required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  DataRow _buildDataRow(int index, Map<String, dynamic> item) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) => index % 2 == 0 ? Colors.white : Colors.green.shade50),
      cells: [
        DataCell(Text(item['name'])),
        DataCell(Text(item['product'])),
        DataCell(Text('${item['quantity']} kg')),
        DataCell(Text(item['date'])),
        DataCell(Text('₱${item['cost'].toStringAsFixed(2)}')),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editBatch(index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteBatch(index),
            ),
          ],
        )),
      ],
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
              _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', context: context, page: Dashboard()),
              _buildDrawerItem(icon: Icons.inventory, title: 'Rice Inventory Stock', context: context, page: RiceStock()),
              _buildDrawerItem(icon: Icons.list_alt, title: 'Inventory', context: context, page: Inventory()),
              _buildDrawerItem(icon: Icons.person, title: 'Supplier', context: context, page: SupplierPage()),
              _buildDrawerItem(icon: Icons.attach_money, title: 'Sales', context: context, page: Inventory()),
              _buildDrawerItem(icon: Icons.notifications, title: 'Notifications', context: context, page: NotificationsPage()),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
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
            Text('Supplier Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Batch Purchases', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: _addNewBatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Add Batch', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade100),
                  columns: const [
                    DataColumn(label: Text('Supplier Name', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Product', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Quantity (kg)', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Date Purchased', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Total Cost (₱)', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(batchData.length, (index) => _buildDataRow(index, batchData[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}