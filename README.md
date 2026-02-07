# FakeStoreAPI Dart Package

A Dart package that provides a service layer to interact with the [FakeStoreAPI](https://fakestoreapi.com/). This package allows fetching data for products, carts, users, and handling authentication while ensuring consistent error handling using `dartz`.

## 📦 Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  fake_store_api_package:
    git:
      url: https://github.com/Maullin1996/fake_store_api_package.git
      ref: v0.0.1
```

Then, run:

```sh
flutter pub get
```

## 🚀 Features

- Fetch a list of products
- Fetch a list of carts
- Fetch a list of users
- Authenticate a user
- Error handling using `dartz`
- Example folder with screens demonstrating API usage

## ⚡ Quick Start

```dart
import 'package:fake_store_api_package/fake_store_api_package.dart';

final apiService = ApiServices();

void loadProducts() async {
  final result = await apiService.fetchProducts();
  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (products) => print('Products: ${products.length}'),
  );
}
```

## 🔗 Supported Endpoints

- `/products`
- `/carts`
- `/users`
- `/auth/login`

## 📌 Usage

### Import the package

```dart
import 'package:fake_store_api_package/fake_store_api_package.dart';
```

### Initialize the API Service

```dart
final apiService = ApiServices();
```

### Fetch Products

```dart
void getProducts() async {
  final result = await apiService.fetchProducts();
  result.fold(
    (error) => print("Error: \$error"),
    (products) => print("Fetched products: \$products"),
  );
}
```

### Fetch Carts

```dart
void getCarts() async {
  final result = await apiService.fetchCarts();
  result.fold(
    (error) => print("Error: \$error"),
    (carts) => print("Fetched carts: \$carts"),
  );
}
```

### Fetch Users

```dart
void getUsers() async {
  final result = await apiService.fetchUsers();
  result.fold(
    (error) => print("Error: \$error"),
    (users) => print("Fetched users: \$users"),
  );
}
```

### Authenticate a User

```dart
void authenticateUser() async {
  final result = await apiService.fetchAuth(
    username: "test_user",
    password: "password123",
  );
  result.fold(
    (error) => print("Authentication failed: \$error"),
    (auth) => print("Authentication successful, Token: \${auth.token}"),
  );
}
```

## 📂 Example Screens

This package includes an `example` folder with four screens demonstrating API usage:

- **AuthScreen**: Handles user authentication.
- **CartScreen**: Displays cart data.
- **ProductScreen**: Shows product listings.
- **UserScreen**: Fetches and displays user details.

## 🛠 Error Handling

All API calls return a `FutureResult<T>` from `dartz`, which is either:
- `Right<T>`: Contains the successful response data.
- `Left<Failure>`: Contains the error details.

Use `.fold()` to handle both success and failure cases.

## 📜 License

This package is open-source and available under the [MIT License](LICENSE).

## 🙌 Contributions

Contributions are welcome! Feel free to submit a pull request or open an issue.

## 📧 Contact

For any questions or support, reach out to Mauricio Llanos www.linkedin.com/in/mauricio-llanos-loaiza-3b0066296.

