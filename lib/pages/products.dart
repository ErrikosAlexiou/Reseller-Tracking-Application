import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Map<String, dynamic>> _products = [];
  Map<String, dynamic>? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _loadProductList();
  }

  Future<void> _loadProductList() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/transactions.json');

      if (await file.exists()) {
        final String response = await file.readAsString();
        final Map<String, dynamic> data = json.decode(response);

        final List<dynamic> productsData = data['products'];

        setState(() {
          _products = List<Map<String, dynamic>>.from(productsData);
        });
      } else {
        print("File not found!");
      }
    } catch (e) {
      print("Error loading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Row(
        children: [
          // Left side: Product list placeholder
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView(
                children:
                    _products.map((product) {
                      return ListTile(
                        title: Text(product['product_name']),
                        subtitle: Text(
                          'Buy: ${product['buy_transactions'].length} | Sell: ${product['sell_transactions'].length}',
                        ),
                        onTap: () {
                          setState(() {
                            _selectedProduct =
                                product; // Update selected product
                          });
                        },
                      );
                    }).toList(),
              ),
            ),
          ),
          // Right side: Product details placeholder
          Expanded(
            flex: 2,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    _selectedProduct == null
                        ? const Center(
                          child: Text('Select a product to see details'),
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedProduct!['product_name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Total Buys: ${_selectedProduct!['buy_transactions'].length}',
                            ),
                            Text(
                              'Total Sells: ${_selectedProduct!['sell_transactions'].length}',
                            ),
                            Text(
                              'Most Recent Sell Date: ${_selectedProduct!['sell_transactions'].isNotEmpty ? _selectedProduct!['sell_transactions'].last['date'] : 'No transactions'}',
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
