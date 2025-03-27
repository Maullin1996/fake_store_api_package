import 'package:flutter/material.dart';
import 'package:fake_store_api_package/domain/models/product_entity.dart';

import '../../config/design/tokens.dart';

/// This file defines the `ProductContainer` widget, which is used to display detailed
/// information about a product in a styled container.
class ProductContainer extends StatelessWidget {
  /// The product information to display, provided as a `Product` object.
  final Product products;

  /// The text theme used for styling the text elements in the widget.
  final TextTheme textTheme;

  const ProductContainer({
    super.key,
    required this.products,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.large),
        color: AppColors.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Displays the product image at the top of the container.
            Center(
              child: SizedBox(
                height: 130,
                child: Image.network(products.image),
              ),
            ),
            SizedBox(height: AppSpacing.small),

            /// Displays the product title in bold text.
            Text(
              'Title: ${products.title}',
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSpacing.small),

            /// Displays the product ID.
            Text('Id: ${products.id.toString()}', style: textTheme.bodyMedium),
            SizedBox(height: AppSpacing.small),

            /// Displays the product category.
            Text('Category: ${products.category}', style: textTheme.bodyMedium),
            SizedBox(height: AppSpacing.small),

            /// Displays the product description, truncated to 3 lines if too long.
            Text(
              'Description: ${products.description}',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.backGroundText,
              ),
            ),
            SizedBox(height: AppSpacing.small),

            /// Displays the product price in bold text with a primary color.
            Text(
              'Price: ${products.price.toString()}',
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
