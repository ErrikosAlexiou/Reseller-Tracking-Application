import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedTimeframe = 'Today';
  String _selectedProduct = 'All Products';

  final List<String> _timeframes = ['Today', 'Last 7 Days', 'Last 28 Days'];
  final List<String> _products = [
    'All Products',
    'Sneakers',
    'T-Shirt',
    'Hat',
  ]; // This should be dynamically populated from JSON in the future

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Row 1: Timeframe and Product Dropdowns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Timeframe Dropdown
              Row(
                children: [
                  const Text('Timeline: ', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: _selectedTimeframe,
                    items:
                        _timeframes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedTimeframe = newValue!;
                      });
                    },
                  ),
                ],
              ),
              // Product Dropdown
              Row(
                children: [
                  const Text('Product: ', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: _selectedProduct,
                    items:
                        _products.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedProduct = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Row 2: Stats Cards
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _StatCard(title: 'Revenue', value: '\$500'),
                _StatCard(title: 'Profit', value: '\$200'),
                _StatCard(title: 'Shipping Costs', value: '\$50'),
                _StatCard(title: 'Total Orders', value: '80'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
