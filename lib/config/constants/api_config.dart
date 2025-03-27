/// This class contains the configuration constants for interacting with the FakeStoreAPI.
/// It includes endpoint paths, the base URL, and default headers for API requests.
class ApiConfig {
  /// Endpoint for fetching product-related data.
  static const String products = '/products';

  /// Endpoint for managing cart-related operations.
  static const String carts = '/carts';

  /// Endpoint for retrieving user-related information.
  static const String users = '/users';

  /// Endpoint for user authentication (login).
  static const String auth = '/auth/login';

  /// The base URL of the FakeStoreAPI.
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Default headers for API requests, specifying JSON content type.
  static Map<String, String> headers = {'Content-Type': 'application/json'};
}
