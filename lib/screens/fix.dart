import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MikrotikChartPage extends StatefulWidget {
  final String ipAddress;
  final String username;
  final String password;

  const MikrotikChartPage({
    Key? key,
    required this.ipAddress,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  _MikrotikChartPageState createState() => _MikrotikChartPageState();
}

class _MikrotikChartPageState extends State<MikrotikChartPage> {
  List<List<FlSpot>> _chartData = [];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch data for the initial tab (Day)
    _fetchDataForTab(0);
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Activty',
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    );
  }

  Widget _buildChart(int index) {
    if (_chartData.isEmpty || index >= _chartData.length) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Colors.white,
      height: 100,
      width: 400,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: _chartData[index],
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: Colors.black,
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });

    // Fetch data for the selected tab
    _fetchDataForTab(index);
  }

  Future<void> _fetchDataForTab(int index) async {
    // Replace the following logic with actual API calls to fetch data for each timeline.
    // Use 'widget.ipAddress', 'widget.username', and 'widget.password' for API authentication.
    // You can use any HTTP library (e.g., http package) to make API requests.

    // Dummy data for the line chart for different timelines.
    List<List<double>> dummyData = [
      // Day
      [0, 10, 20, 30, 25, 15, 5],
      // Week
      [0, 20, 15, 10, 35, 30, 20],
      // Month
      [0, 25, 30, 20, 35, 45, 50],
      // Year
      [0, 15, 10, 25, 20, 35, 30],
    ];

    // Convert dummy data to FlSpot format and update the state.
    setState(() {
      _chartData = dummyData
          .map((data) => data
              .asMap()
              .entries
              .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
              .toList())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChart(_selectedTabIndex),
          ),
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabItem('Day', 0),
                _buildTabItem('Week', 1),
                _buildTabItem('Month', 2),
                _buildTabItem('Year', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    return InkWell(
      onTap: () {
        _onTabSelected(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == _selectedTabIndex
                  ? Colors.white
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: index == _selectedTabIndex ? Colors.white : Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
