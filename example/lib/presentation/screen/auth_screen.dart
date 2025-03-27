import 'package:flutter/material.dart';
import 'package:example/presentation/helpers/validate_input.dart';
import 'package:fake_store_api_package/methods/api_services.dart';
import 'package:go_router/go_router.dart';
import 'package:example/presentation/widgets/custom_text_form_field.dart';

import '../../config/design/tokens.dart';

/// This file demonstrates the usage of the `fetchAuth()` method from the `ApiServices` class.
/// It provides a form for the user to input their username and password, sends the credentials
/// to the API, and displays the authentication token or an error message based on the result.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// Instance of `ApiServices` to interact with the API.
  final ApiServices _apiServices = ApiServices();

  /// Controller for the username input field.
  final TextEditingController _usernameController = TextEditingController();

  /// Controller for the password input field.
  final TextEditingController _passwordController = TextEditingController();

  /// Key for the form to validate user input.
  final _formKey = GlobalKey<FormState>();

  /// Indicates whether the authentication request is in progress.
  bool _isLoading = false;

  /// Stores any error message encountered during the authentication request.
  String? _errorMessage;

  /// Stores the authentication token returned by the API.
  String? _token;

  @override
  void initState() {
    super.initState();
  }

  /// Sends the username and password to the API using the `fetchAuth()` method.
  ///
  /// Handles loading states and updates the UI based on the result:
  /// - On success: Displays the authentication token.
  /// - On failure: Displays an error message.
  Future<void> _fetchProducts({
    required String username,
    required String password,
  }) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final authResult = await _apiServices.fetchAuth(
      username: username,
      password: password,
    );

    authResult.fold(
      (failure) {
        setState(() {
          _token = null;
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (auth) {
        setState(() {
          _isLoading = false;
          _errorMessage = null;
          _token = auth.token;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('AUTHENTICATION', style: textTheme.displayMedium),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryVariant),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 233, 233),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.medium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.extraLarge),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Input field for the username.
                    CustomTextFormField(
                      controller: _usernameController,
                      title: 'Username',
                      validator: (value) => validateInput(value),
                    ),
                    SizedBox(height: AppSpacing.medium),

                    /// Input field for the password.
                    CustomTextFormField(
                      controller: _passwordController,
                      title: 'Password',
                      validator: (value) => validateInput(value),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Button to submit the form and trigger the authentication request.
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed:
                      _isLoading
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              _fetchProducts(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                  child:
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Text('Enter', style: textTheme.displaySmall),
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Displays an error message or the authentication token based on the result.
              _errorMessage != null
                  ? Text(
                    _errorMessage!,
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.error,
                    ),
                  )
                  : Text(
                    "Access token: ${_token ?? 'Enter Authentication params'}",
                    style: textTheme.bodyLarge,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
