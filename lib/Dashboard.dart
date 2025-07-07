import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rice_trax/RiceStock.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _touchedIndex = -1;
  int _hoveredCardIndex = -1;
  int _selectedCardIndex = -1; // Track which card is selected

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
                decoration: BoxDecoration(
                  color: Colors.green[900],
                ),
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
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.inventory,
                title: 'Rice Inventory Stock',
                context: context,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RiceStock()),
                  );
                },
              ),
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
          style: TextStyle(fontWeight: FontWeight.bold),
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
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 16),

          // Card 1 - Sales
          GestureDetector(
            onTap: () => setState(() => _selectedCardIndex = 0),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoveredCardIndex = 0),
              onExit: (_) => setState(() => _hoveredCardIndex = -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(_hoveredCardIndex == 0 ? 1.02 : 1.0),
                child: _buildDashboardCard(
                  icon: Icons.attach_money,
                  title: 'Total Sales Today',
                  value: '₱ 15,400',
                  isHovered: _hoveredCardIndex == 0,
                  isSelected: _selectedCardIndex == 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Card 2 - Stock
          GestureDetector(
            onTap: () => setState(() => _selectedCardIndex = 1),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoveredCardIndex = 1),
              onExit: (_) => setState(() => _hoveredCardIndex = -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(_hoveredCardIndex == 1 ? 1.02 : 1.0),
                child: _buildDashboardCard(
                  icon: Icons.inventory_2,
                  title: 'Total Stock (sacks)',
                  value: '930',
                  isHovered: _hoveredCardIndex == 1,
                  isSelected: _selectedCardIndex == 1,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Card 3 - Sold
          GestureDetector(
            onTap: () => setState(() => _selectedCardIndex = 2),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoveredCardIndex = 2),
              onExit: (_) => setState(() => _hoveredCardIndex = -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(_hoveredCardIndex == 2 ? 1.02 : 1.0),
                child: _buildDashboardCard(
                  icon: Icons.shopping_cart,
                  title: 'Sold Stocks (sacks)',
                  value: '250',
                  isHovered: _hoveredCardIndex == 2,
                  isSelected: _selectedCardIndex == 2,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Card 4 - Low Stock
          GestureDetector(
            onTap: () => setState(() => _selectedCardIndex = 3),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoveredCardIndex = 3),
              onExit: (_) => setState(() => _hoveredCardIndex = -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.identity()..scale(_hoveredCardIndex == 3 ? 1.02 : 1.0),
                child: _buildDashboardCard(
                  icon: Icons.warning,
                  title: 'Low Stocks',
                  value: '1 item',
                  isHovered: _hoveredCardIndex == 3,
                  isSelected: _selectedCardIndex == 3,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),

          _buildSectionTitle('Inventory Breakdown (sacks)'),
          SizedBox(height: 200, child: _buildPieChart()),
          SizedBox(height: 24),

          _buildSectionTitle('Monthly Sales (₱)'),
          SizedBox(height: 200, child: _buildBarChart()),

          SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiceStock()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'View Rice Inventory Stock',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
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

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String value,
    bool isHovered = false,
    bool isSelected = false,
  }) {
    final bool isActive = isHovered || isSelected;
    
    return Card(
      elevation: isActive ? 8 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isActive ? Colors.green[800]! : Colors.grey[300]!,
          width: isActive ? 2 : 1,
        ),
      ),
      color: isSelected ? Colors.green[50] : Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? Colors.green[800]! : Colors.grey[300]!,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]
                    : null,
              ),
              child: Icon(
                icon, 
                color: isActive ? Colors.white : Colors.green[800],
                size: 28,
              ),
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
                      color: isActive ? Colors.green[900] : Colors.green[800],
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.green[900] : Colors.green[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                _touchedIndex = -1;
                return;
              }
              _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sections: [
          PieChartSectionData(
            value: 400,
            title: '400',
            color: Colors.green[800],
            radius: _touchedIndex == 0 ? 70 : 60,
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 300,
            title: '300',
            color: Colors.green[400],
            radius: _touchedIndex == 1 ? 70 : 60,
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 80,
            title: '80',
            color: Colors.green[200],
            radius: _touchedIndex == 2 ? 70 : 60,
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
        sectionsSpace: 0,
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
                return Text(months[value.toInt() % months.length],
                    style: TextStyle(fontSize: 12, color: Colors.green[800]));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}',
                style: TextStyle(fontSize: 10, color: Colors.green[800]),
              ),
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 400, color: Colors.green[800])]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 300, color: Colors.green[800])]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 500, color: Colors.green[800])]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 200, color: Colors.green[800])]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 300, color: Colors.green[800])]),
        ],
      ),
    );
  }
}