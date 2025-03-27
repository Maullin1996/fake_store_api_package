///Api fake store response to convert Dart object using QuickType.
class CartsFakeStore {
  final int id;
  final int userId;
  final List<ProductsId> productsId;

  CartsFakeStore({
    required this.id,
    required this.userId,
    required this.productsId,
  });

  factory CartsFakeStore.fromJson(Map<String, dynamic> json) => CartsFakeStore(
    id: json["id"],
    userId: json["userId"],
    productsId: List<ProductsId>.from(
      json["products"].map((x) => ProductsId.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "products": List<dynamic>.from(productsId.map((x) => x.toJson())),
  };
}

class ProductsId {
  final int productId;

  ProductsId({required this.productId});

  factory ProductsId.fromJson(Map<String, dynamic> json) =>
      ProductsId(productId: json["productId"]);

  Map<String, dynamic> toJson() => {"productId": productId};
}
