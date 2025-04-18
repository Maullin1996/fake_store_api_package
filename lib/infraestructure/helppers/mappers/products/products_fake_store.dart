///Api fake store response to convert Dart object using QuickType.
class ProductsFakeStore {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ProductsFakeStore({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductsFakeStore.fromJson(Map<String, dynamic> json) =>
      ProductsFakeStore(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };
}
