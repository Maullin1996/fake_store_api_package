import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/errors/index_errors.dart';

import '../../helpers/mappers.dart';

/// This class is responsible for handling authentication requests to the FakeStoreAPI.
/// It provides methods to authenticate users by sending their credentials to the API.
class AuthFakeStoreApi {
  /// The base URL of the FakeStoreAPI.
  final String baseUrl;

  /// The HTTP client used to make API requests.
  final http.Client client;

  /// The error handler used to process and map API errors.
  final ApiErrorHandler errorHandler;

  /// Constructor for creating an instance of `AuthFakeStoreApi`.
  ///
  /// - [baseUrl]: The base URL for the API (default is `ApiConfig.baseUrl`).
  /// - [client]: An optional HTTP client (default is a new `http.Client` instance).
  /// - [errorHandler]: An optional error handler (default is a new `ApiErrorHandler` instance).
  AuthFakeStoreApi({
    this.baseUrl = ApiConfig.baseUrl,
    http.Client? client,
    ApiErrorHandler? errorHandler,
  }) : client = client ?? http.Client(),
       errorHandler = errorHandler ?? ApiErrorHandler();

  /// Authenticates a user by sending their username and password to the API.
  ///
  /// - [username]: The username of the user.
  /// - [password]: The password of the user.
  ///
  /// Returns an `Auth` object containing the authentication token if the request is successful.
  ///
  /// Throws a `FetchFakeStoreException` if the API request fails.
  Future<TokenFakeStore> authentication({
    required String username,
    required String password,
  }) async {
    // Construct the URI for the authentication endpoint.
    final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.auth}');

    // Send a POST request with the username and password as the body.
    final response = await client.post(
      uri,
      body: {"username": username, "password": password},
    );

    // If the response status code is 200, parse the response and return an `Auth` object.
    if (response.statusCode == 200) {
      final authToken = TokenFakeStore.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      return authToken;
    } else {
      // If the request fails, throw a `FetchFakeStoreException` with an appropriate error message.
      throw FetchFakeStoreException(
        message: 'API request failed with status: ${response.statusCode}',
        error: FetchFakeStoreError.notFound,
      );
    }
  }
}
