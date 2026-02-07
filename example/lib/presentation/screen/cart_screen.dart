import 'package:example/domain/models.dart';
import 'package:example/infraestructure/helppers/mappers.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/design/tokens.dart';
import '../widgets/index.dart';

/// This file demonstrates the usage of the `fetchCarts()` method from the `ApiServices` class.
/// It fetches a list of carts from the API and displays their information in a styled list.
/// The screen handles loading states, error messages, and displays cart data using the `CartContainer` widget.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  /// Instance of `ApiServices` to interact with the API.
  final ApiServices _apiServices = ApiServices();

  /// List of carts fetched from the API.
  List<Carts> _carts = [];

  /// Indicates whether the data is currently being loaded.
  bool _isLoading = true;

  /// Stores any error message encountered during the API request.
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCarts();
  }

  /// Fetches the list of carts from the API using the `fetchCarts()` method.
  ///
  /// Handles loading states and updates the UI based on the result:
  /// - On success: Updates the `_carts` list and stops the loading indicator.
  /// - On failure: Displays an error message.
  Future<void> _fetchCarts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final cartsResult = await _apiServices.fetchCarts();

    cartsResult.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (carts) {
        setState(() {
          _carts =
              carts
                  .map((cart) => CartsMapper.cartFakeStoreToCard(cart))
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
        title: Text('Carts', style: textTheme.displayMedium),
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
  /// - Displays a list of carts if the data is successfully fetched.
  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $_errorMessage',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.xmedium),
            ElevatedButton(onPressed: _fetchCarts, child: Text('Reload')),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.small,
        vertical: AppSpacing.medium,
      ),
      itemCount: _carts.length,
      itemBuilder: (BuildContext context, int index) {
        final carts = _carts[index];
        return CartContainer(carts: carts);
      },
    );
  }
}
