import 'package:flutter/material.dart';
import 'package:fake_store_api_package/domain/models/cart_entity.dart';

import '../../config/design/tokens.dart';

/// This file defines the `CartContainer` widget, which is used to display detailed
/// information about a cart in a styled container.
class CartContainer extends StatelessWidget {
  /// The cart information to display, provided as a `Carts` object.
  final Carts carts;

  /// Constructor for creating a `CartContainer` instance.
  ///
  /// - [carts]: The cart data to display.
  const CartContainer({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.medium),
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.medium,
        horizontal: AppSpacing.medium,
      ),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Displays the cart ID.
          Text('Id: ${carts.id}'),
          SizedBox(height: AppSpacing.medium),

          /// Displays the user ID associated with the cart.
          Text('UserId: ${carts.userId}'),
          SizedBox(height: AppSpacing.medium),

          /// Displays the list of products in the cart.
          Text('Products: '),
          SizedBox(height: AppSpacing.medium),

          /// A list view to display each product in the cart.
          ListView.separated(
            padding: EdgeInsets.only(left: AppSpacing.medium),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: carts.products.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: AppSpacing.medium);
            },
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Displays the product details.
                  Text('Product: ${carts.products[index]}'),
                  SizedBox(height: AppSpacing.xlarge),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
