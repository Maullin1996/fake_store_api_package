/// A class that represents a product entity.
class Product {
  /// The unique identifier of the product.
  final int id;

  /// The title of the product.
  final String title;

  /// The price of the product.
  final double price;

  /// The description of the product.
  final String description;

  /// The category of the product.
  final String category;

  /// The image URL of the product.
  final String image;

  /// Creates a [Product] instance with the given [id], [title], [price], [description], [category], and [image].
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  /// Creates a copy of this [Product] instance with the given fields replaced
  /// by new values.
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }
}
