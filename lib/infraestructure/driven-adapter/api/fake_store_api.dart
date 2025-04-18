import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/infraestructure/helppers/mappers.dart';

import '../../../errors/index_errors.dart';

/// This class is responsible for interacting with the FakeStoreAPI.
/// It provides methods to fetch data for products, carts, and users.
class FakeStoreApi {
  /// The base URL of the FakeStoreAPI.
  final String baseUrl;

  /// The HTTP client used to make API requests.
  final http.Client client;

  /// The error handler used to process and map API errors.
  final ApiErrorHandler errorHandler;

  /// Constructor for creating an instance of `FakeStoreApi`.
  ///
  /// - [baseUrl]: The base URL for the API (default is `ApiConfig.baseUrl`).
  /// - [client]: An optional HTTP client (default is a new `http.Client` instance).
  /// - [errorHandler]: An optional error handler (default is a new `ApiErrorHandler` instance).
  FakeStoreApi({
    http.Client? client,
    ApiErrorHandler? errorHandler,
    this.baseUrl = ApiConfig.baseUrl,
  }) : client = client ?? http.Client(),
       errorHandler = errorHandler ?? ApiErrorHandler();

  /// A generic method to fetch data from the API.
  ///
  /// - [endpoint]: The API endpoint to fetch data from.
  /// - [fromJson]: A function to parse the JSON response into a specific model.
  /// - [mapper]: A function to map the parsed model to the domain model.
  ///
  /// Returns a list of domain models of type `T`.
  ///
  /// Throws a `FetchFakeStoreException` if the API request fails.
  Future<List<F>> _fetchData<F>({
    required String endpoint,
    required F Function(Map<String, dynamic>) fromJson,
  }) async {
    // Construct the URI for the API endpoint.
    final uri = Uri.parse('$baseUrl$endpoint');

    // Send a GET request to the API.
    final response = await client.get(uri, headers: ApiConfig.headers);

    // If the response is successful, parse the JSON and map it to the domain model.
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      final List<F> fakeStoreItems =
          jsonList.map((json) => fromJson(json)).toList();

      return fakeStoreItems;
    } else {
      // If the request fails, throw an exception with an appropriate error message.
      throw FetchFakeStoreException(
        message: 'API request failed with status: ${response.statusCode}',
        error: FetchFakeStoreError.notFound,
      );
    }
  }

  /// Fetches a list of products from the API.
  ///
  /// - [endpoint]: The API endpoint for fetching products.
  ///
  /// Returns a list of `Product` objects.
  Future<List<ProductsFakeStore>> fetchProducts(String endpoint) async {
    return _fetchData(endpoint: endpoint, fromJson: ProductsFakeStore.fromJson);
  }

  /// Fetches a list of carts from the API.
  ///
  /// - [endpoint]: The API endpoint for fetching carts.
  ///
  /// Returns a list of `Carts` objects.
  Future<List<CartsFakeStore>> fetchCart(String endpoint) async {
    return _fetchData<CartsFakeStore>(
      endpoint: endpoint,
      fromJson: CartsFakeStore.fromJson,
    );
  }

  /// Fetches a list of users from the API.
  ///
  /// - [endpoint]: The API endpoint for fetching users.
  ///
  /// Returns a list of `User` objects.
  Future<List<UsersFakeStore>> fetchUser(String endpoint) async {
    return _fetchData<UsersFakeStore>(
      endpoint: endpoint,
      fromJson: UsersFakeStore.fromJson,
    );
  }
}
