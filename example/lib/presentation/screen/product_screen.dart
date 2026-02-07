import 'package:example/domain/models/product_entity.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:example/config/design/tokens.dart';

import '../../infraestructure/helppers/products/product_mapper.dart';
import '../widgets/index.dart';

/// This file demonstrates the usage of the `fetchProducts()` method from the `ApiServices` class.
/// It fetches a list of products from the API and displays their information in a styled list.
/// The screen handles loading states, error messages, and displays product data using the `ProductContainer` widget.
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  /// Instance of `ApiServices` to interact with the API.
  final ApiServices _apiServices = ApiServices();

  /// List of products fetched from the API.
  List<Product> _products = [];

  /// Indicates whether the data is currently being loaded.
  bool _isLoading = true;

  /// Stores any error message encountered during the API request.
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  /// Fetches the list of products from the API using the `fetchProducts()` method.
  ///
  /// Handles loading states and updates the UI based on the result:
  /// - On success: Updates the `_products` list and stops the loading indicator.
  /// - On failure: Displays an error message.
  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final productsResult = await _apiServices.fetchProducts();

    productsResult.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (products) {
        setState(() {
          _products =
              products
                  .map(
                    (products) =>
                        ProductMapper.productFakeStoreToProduct(products),
                  )
                  .toList();
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 233, 233),
        title: Text('PRODUCTS', style: textTheme.displayMedium),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryVariant),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 234, 233, 233),
      body: _buildBody(),
    );
  }

  /// Builds the body of the screen based on the current state:
  /// - Displays a loading indicator while fetching data.
  /// - Shows an error message if the API request fails.
  /// - Displays a list of products if the data is successfully fetched.
  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $_errorMessage',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.xmedium),
            ElevatedButton(onPressed: _fetchProducts, child: Text('Reload')),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.medium,
        horizontal: AppSpacing.medium,
      ),
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int index) {
        final products = _products[index];
        return ProductContainer(products: products, textTheme: textTheme);
      },
    );
  }
}
