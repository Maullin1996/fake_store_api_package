import 'package:example/presentation/widgets/user_container.dart';
import 'package:fake_store_api_package/domain/models/user_entity.dart';
import 'package:fake_store_api_package/methods/api_services.dart';
import 'package:flutter/material.dart';
import 'package:example/config/design/tokens.dart';
import 'package:go_router/go_router.dart';

/// This file demonstrates the usage of the `fetchUsers()` method from the `ApiServices` class.
/// It fetches a list of users from the API and displays their information in a styled list.
/// The screen handles loading states, error messages, and displays user data using the `UserContainer` widget.
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  /// Instance of `ApiServices` to interact with the API.
  final ApiServices _apiServices = ApiServices();

  /// List of users fetched from the API.
  late List<User> _users;

  /// Indicates whether the data is currently being loaded.
  bool _isLoading = true;

  /// Stores any error message encountered during the API request.
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  /// Fetches the list of users from the API using the `fetchUsers()` method.
  ///
  /// Handles loading states and updates the UI based on the result:
  /// - On success: Updates the `_users` list and stops the loading indicator.
  /// - On failure: Displays an error message.
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final usersResult = await _apiServices.fetchUsers();

    usersResult.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (users) {
        setState(() {
          _users = users;
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
        title: Text('USERS INFORMATION', style: textTheme.displayMedium),
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
  /// - Displays a list of users if the data is successfully fetched.
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
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: AppSpacing.xmedium),
            ElevatedButton(
              onPressed: _fetchUsers,
              child: Text(
                'Reload',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.medium,
        horizontal: AppSpacing.xmedium,
      ),
      itemCount: _users.length,
      itemBuilder: (BuildContext context, int index) {
        final userInformation = _users[index];
        return UserContainer(
          userInformation: userInformation,
          textTheme: textTheme,
        );
      },
    );
  }
}
