import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'RiceStock.dart';
import 'Inventory.dart';
import 'NotificationsPage.dart';
import 'Supplier.dart';
import 'Sales.dart';  
import 'Settings.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedCardIndex = -1;
  int touchedIndex = -1;

  void onCardTap(int index) {
    setState(() {
      selectedCardIndex = index;
    });
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
                    Text('RiceTrax',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
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
              _buildDrawerItem(icon: Icons.list_alt, title: 'Inventory', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Inventory()));
              }),
              _buildDrawerItem(icon: Icons.local_shipping, title: 'Supplier', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Supplier()));
              }),
              _buildDrawerItem(icon: Icons.attach_money, title: 'Sales', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sales()));
              }),
              _buildDrawerItem(icon: Icons.notifications, title: 'Notification', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
              }),
              _buildDrawerItem(icon: Icons.settings, title: 'Settings', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Settings()));
              }),
              _buildDrawerItem(icon: Icons.logout, title: 'Logout', context: context, onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
          Text('Dashboard',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800])),
          SizedBox(height: 16),
          _buildDashboardCard(icon: Icons.attach_money, title: 'Total Sales Today', value: '₱ 15,400', index: 0),
          SizedBox(height: 16),
          _buildDashboardCard(icon: Icons.inventory_2, title: 'Total Stock (sacks)', value: '930', index: 1),
          SizedBox(height: 16),
          _buildDashboardCard(icon: Icons.shopping_cart, title: 'Sold Stocks (sacks)', value: '250', index: 2),
          SizedBox(height: 16),
          _buildDashboardCard(icon: Icons.warning, title: 'Low Stocks', value: '1 item', index: 3),
          SizedBox(height: 24),
          _buildSectionTitle('Inventory Breakdown (sacks)'),
          SizedBox(height: 200, child: _buildPieChart()),
          SizedBox(height: 24),
          _buildSectionTitle('Monthly Sales (₱)'),
          SizedBox(height: 200, child: _buildBarChart()),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required BuildContext context, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _buildDashboardCard({required IconData icon, required String title, required String value, required int index}) {
    final isSelected = selectedCardIndex == index;

    return GestureDetector(
      onTap: () => onCardTap(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.white,
          border: Border.all(color: isSelected ? Colors.green : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.green[800], size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, color: Colors.green[800])),
                  SizedBox(height: 8),
                  Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[800])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]));
  }

  Widget _buildPieChart() {
    final pieData = [
      {'value': 400.0, 'title': '400', 'color': Colors.green[800]},
      {'value': 300.0, 'title': '300', 'color': Colors.green[400]},
      {'value': 80.0, 'title': '80', 'color': Colors.green[200]},
    ];

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (event, response) {
            setState(() {
              if (!event.isInterestedForInteractions || response == null || response.touchedSection == null) {
                touchedIndex = -1;
              } else {
                touchedIndex = response.touchedSection!.touchedSectionIndex;
              }
            });
          },
        ),
        sections: List.generate(pieData.length, (i) {
          final isTouched = i == touchedIndex;
          final radius = isTouched ? 80.0 : 60.0;

          return PieChartSectionData(
            value: pieData[i]['value'] as double,
            title: pieData[i]['title'] as String,
            color: pieData[i]['color'] as Color,
            radius: radius,
          );
        }),
        sectionsSpace: 2,
        centerSpaceRadius: 0,
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, _) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
                return Text(months[value.toInt() % months.length], style: TextStyle(fontSize: 12, color: Colors.green[800]));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) => Text('${value.toInt()}', style: TextStyle(fontSize: 10, color: Colors.green[800])),
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 400, color: Colors.green[200])]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 300, color: Colors.green[200])]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 500, color: Colors.green[200])]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 200, color: Colors.green[200])]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 300, color: Colors.green[200])]),
        ],
      ),
    );
  }
}