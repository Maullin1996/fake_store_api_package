import 'package:go_router/go_router.dart';

import '../../presentation/screen/screens.dart';

/// This file defines the routing configuration for the example application.
/// It uses the `GoRouter` package to manage navigation between different screens.
/// Each route corresponds to a specific feature or API demonstration in the app.
final GoRouter router = GoRouter(
  /// The initial route of the application, which is the home screen.
  initialLocation: '/',

  /// A list of routes defining the navigation paths and their corresponding screens.
  routes: [
    /// Route for the home screen.
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),

    /// Route for the user screen, demonstrating how to fetch and display user data.
    GoRoute(path: '/users', builder: (context, state) => UserScreen()),

    /// Route for the product screen, demonstrating how to fetch and display product data.
    GoRoute(path: '/products', builder: (context, state) => ProductScreen()),

    /// Route for the cart screen, demonstrating how to fetch and display cart data.
    GoRoute(path: '/carts', builder: (context, state) => CartScreen()),

    /// Route for the authentication screen, demonstrating how to handle user authentication.
    GoRoute(path: '/auth', builder: (context, state) => AuthScreen()),
  ],
);
