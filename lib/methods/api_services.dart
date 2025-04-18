import 'package:dartz/dartz.dart';
import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/errors/index_errors.dart';
import 'package:fake_store_api_package/infraestructure/driven-adapter/index.dart';
import 'package:fake_store_api_package/infraestructure/helppers/mappers.dart';

import '../typedef/typedef.dart';

/// This class acts as a service layer to interact with the FakeStoreAPI.
/// It provides methods to fetch data for products, carts, users, and authentication.
/// The class ensures consistent error handling and wraps results in a `FutureResult`
/// to handle success or failure scenarios.
class ApiServices {
  /// Instance of `FakeStoreApi` for fetching products, carts, and users.
  final FakeStoreApi _fakeStoreApi;

  /// Instance of `AuthFakeStoreApi` for handling authentication requests.
  final AuthFakeStoreApi _authFakeStoreApi;

  /// Instance of `ApiErrorHandler` for processing and mapping API errors.
  final ApiErrorHandler _errorHandler;

  /// Constructor for creating an instance of `ApiServices`.
  ///
  /// - [fakeStoreApi]: An optional `FakeStoreApi` instance (default is a new instance).
  /// - [authFakeStoreApi]: An optional `AuthFakeStoreApi` instance (default is a new instance).
  /// - [errorHandler]: An optional `ApiErrorHandler` instance (default is a new instance).
  ApiServices({
    FakeStoreApi? fakeStoreApi,
    AuthFakeStoreApi? authFakeStoreApi,
    ApiErrorHandler? errorHandler,
  }) : _fakeStoreApi = fakeStoreApi ?? FakeStoreApi(),
       _authFakeStoreApi = authFakeStoreApi ?? AuthFakeStoreApi(),
       _errorHandler = errorHandler ?? ApiErrorHandler();

  /// A generic method to fetch data from the API.
  ///
  /// - [fetchFunction]: A function that performs the API request.
  ///
  /// Returns a `FutureResult` containing either the fetched data (`Right`) or an error (`Left`).
  FutureResult<T> _fetchData<T>({
    required Future<T> Function() fetchFunction,
  }) async {
    try {
      final data = await fetchFunction();
      return Right(data);
    } catch (error) {
      return Left(_errorHandler.handle(error));
    }
  }

  /// Fetches a list of products from the API.
  ///
  /// Returns a `FutureResult` containing a list of `Product` objects or an error.
  FutureResult<List<ProductsFakeStore>> fetchProducts({String? category}) {
    return _fetchData<List<ProductsFakeStore>>(
      fetchFunction:
          () => _fakeStoreApi.fetchProducts(
            category == null
                ? ApiConfig.products
                : '${ApiConfig.products}$category',
          ),
    );
  }

  /// Fetches a list of carts from the API.
  ///
  /// Returns a `FutureResult` containing a list of `Carts` objects or an error.
  FutureResult<List<CartsFakeStore>> fetchCarts() {
    return _fetchData<List<CartsFakeStore>>(
      fetchFunction: () => _fakeStoreApi.fetchCart(ApiConfig.carts),
    );
  }

  /// Fetches a list of users from the API.
  ///
  /// Returns a `FutureResult` containing a list of `User` objects or an error.
  FutureResult<List<UsersFakeStore>> fetchUsers() {
    return _fetchData<List<UsersFakeStore>>(
      fetchFunction: () => _fakeStoreApi.fetchUser(ApiConfig.users),
    );
  }

  /// Authenticates a user by sending their username and password to the API.
  ///
  /// - [username]: The username of the user.
  /// - [password]: The password of the user.
  ///
  /// Returns a `FutureResult` containing an `Auth` object with the authentication token or an error.
  FutureResult<TokenFakeStore> fetchAuth({
    required String username,
    required String password,
  }) {
    return _fetchData<TokenFakeStore>(
      fetchFunction:
          () => _authFakeStoreApi.authentication(
            username: username,
            password: password,
          ),
    );
  }
}
