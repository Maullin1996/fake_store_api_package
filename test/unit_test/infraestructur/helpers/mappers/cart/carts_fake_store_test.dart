import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('throws TypeError with invalid JSON for the cart response', () {
    // Arrange
    // Mock the API response
    final mockResponse = {
      'ids': 1,
      'userIds': 1,
      'productss': [
        {"productId": 1},
        {"productId": 2},
        {"productId": 3},
      ],
    };
    //Assert
    expect(
      () => CartsFakeStore.fromJson(mockResponse),
      throwsA(isA<TypeError>()),
    );
  });
  test('correctly parses valid JSON for the cart response', () {
    // Arrange
    // Mock the API response
    final mockResponse = {
      'id': 1,
      'userId': 1,
      'products': [
        {"productId": 1},
        {"productId": 2},
        {"productId": 3},
      ],
    };
    //Act
    final carts = CartsFakeStore.fromJson(mockResponse);
    //Assert
    expect(carts, isA<CartsFakeStore>());
    expect(carts.id, 1);
    expect(carts.userId, 1);
    expect(carts.productsId.map((item) => item.productId).toList(), [1, 2, 3]);
  });
  test('Parses cart with a sigle product', () {
    // Arrange
    final mockResponse = {'id': 3, 'userId': 42, 'products': []};
    // Act
    final cart = CartsFakeStore.fromJson(mockResponse);

    //Assert
    expect(cart.productsId, isEmpty);
  });
  test('throws when a required field is null', () {
    // Act
    final mockResponse = {'id': null, 'userId': 42, 'products': []};

    //Assert
    expect(
      () => CartsFakeStore.fromJson(mockResponse),
      throwsA(isA<TypeError>()),
    );
  });
  test('serializes CartsFakeStore to correct JSON', () {
    final cart = CartsFakeStore(
      id: 1,
      userId: 10,
      productsId: [CartItem(productId: 5), CartItem(productId: 6)],
    );

    final json = cart.toJson();

    expect(json, {
      'id': 1,
      'userId': 10,
      'products': [
        {'productId': 5},
        {'productId': 6},
      ],
    });
  });
}
