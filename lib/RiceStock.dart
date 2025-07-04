import 'package:flutter/material.dart';

class RiceStock extends StatelessWidget {
  final List<List<String>> data = [
    ['Name', 'Stock', 'Sold', 'Price', 'Status'],
    ['Maharlika', '54', '15', '₱58', 'In Stock'],
    ['Dinorado', '45', '10', '₱59', 'In Stock'],
    ['Jasmin', '40', '10', '₱55', 'In Stock'],
    ['Angelika', '30', '10', '₱56', 'Low Stock'],
    ['Sinandomeng', '0', '9', '₱54', 'Out of Stock'],
  ];

  @override
  Widget build(BuildContext context) {
    int lowStockCount = data
        .skip(1)
        .where((row) => row.last == 'Low Stock')
        .length;

    int outOfStockCount = data
        .skip(1)
        .where((row) => row.last == 'Out of Stock')
        .length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Center(
          child: Text(
            'Rice Inventory Stock',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // 🔶 Low Stock Card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8.0),
            child: Card(
              color: Colors.orange[100],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.orange[900], size: 36),
                title: Text(
                  'Low Stock Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[900],
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$lowStockCount item(s) low on stock',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[800],
                  ),
                ),
              ),
            ),
          ),

          // 🔴 Out of Stock Card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8.0),
            child: Card(
              color: Colors.red[100],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.error, color: Colors.red[900], size: 36),
                title: Text(
                  'Out of Stock Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$outOfStockCount item(s) out of stock',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red[800],
                  ),
                ),
              ),
            ),
          ),

          // 📋 Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black, width: 1),
                  defaultColumnWidth: FixedColumnWidth(120),
                                 // ...existing code...
children: data.map((row) {
  bool isHeader = row == data.first;

  // Set row color based on status (skip header)
  Color? rowColor;
  if (!isHeader) {
    String status = row[4];
    if (status == 'In Stock') {
      rowColor = Colors.green[100];
    } else if (status == 'Low Stock') {
      rowColor = Colors.orange[100];
    } else if (status == 'Out of Stock') {
      rowColor = Colors.red[100];
    }
  }

  return TableRow(
    decoration: BoxDecoration(
      color: isHeader ? Colors.grey[300] : rowColor,
    ),
    children: row.map((cell) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          cell,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList(),
  );
}).toList(),
// ...existing code...
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}