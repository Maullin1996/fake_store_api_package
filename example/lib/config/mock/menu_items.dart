import 'package:flutter/material.dart';

/// This file defines a list of menu items used in the example application.
/// Each menu item represents a feature or screen that demonstrates how to use the package.
/// The menu items include a title, subtitle, route, and icon for navigation and display purposes.
class MenuItems {
  /// The title of the menu item, displayed as the main label.
  final String title;

  /// A brief description or subtitle for the menu item.
  final String subTitle;

  /// The route associated with the menu item, used for navigation.
  final String route;

  /// The icon representing the menu item visually.
  final IconData icon;

  /// Constructor for creating a `MenuItems` instance.
  ///
  /// - [title]: The title of the menu item.
  /// - [subTitle]: A brief description of the menu item.
  /// - [route]: The navigation route for the menu item.
  /// - [icon]: The icon representing the menu item.
  MenuItems({
    required this.title,
    required this.subTitle,
    required this.route,
    required this.icon,
  });
}

/// A list of menu items used in the example application.
/// Each item corresponds to a specific feature or API endpoint demonstration.
final List<MenuItems> menuItems = [
  MenuItems(
    title: 'fetchUsers',
    subTitle:
        'In this Screen you could watch all the users information registered in the API',
    route: '/users',
    icon: Icons.person,
  ),
  MenuItems(
    title: 'fetchProducts',
    subTitle: 'In this Screen you could watch all the products in the API',
    route: '/products',
    icon: Icons.app_registration_rounded,
  ),
  MenuItems(
    title: 'fetchCarts',
    subTitle:
        'In this Screen you could see the structure of the cart in the API',
    route: '/carts',
    icon: Icons.shopping_cart_outlined,
  ),
  MenuItems(
    title: 'fetchAuth',
    subTitle:
        'In this screen you could see the structure for the Authentication',
    route: '/auth',
    icon: Icons.account_circle_sharp,
  ),
];
