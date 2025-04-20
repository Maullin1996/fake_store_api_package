///Api fake store response to convert Dart object using QuickType.
class CartsFakeStore {
  final int id;
  final int userId;
  final List<CartItem> productsId;

  CartsFakeStore({
    required this.id,
    required this.userId,
    required this.productsId,
  });

  factory CartsFakeStore.fromJson(Map<String, dynamic> json) => CartsFakeStore(
    id: json["id"],
    userId: json["userId"],
    productsId: List<CartItem>.from(
      json["products"].map((x) => CartItem.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "products": List<dynamic>.from(productsId.map((x) => x.toJson())),
  };
}

class CartItem {
  final int productId;

  CartItem({required this.productId});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      CartItem(productId: json["productId"]);

  Map<String, dynamic> toJson() => {"productId": productId};
}
