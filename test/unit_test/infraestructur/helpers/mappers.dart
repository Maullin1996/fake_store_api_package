import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('check if the json follows the Mapper structure', () {
    test('throws TypeError with invalid JSON for the products response', () {
      // Arrange
      // Mock the API response
      final mockResponse = {
        'ids': 1,
        'titles': 'Product 1',
        'prices': 10.0,
        'descriptions': 'Description 1',
        'categorys': 'category 1',
        'images': 'image1',
      };
      // Assert
      expect(
        () => ProductsFakeStore.fromJson(mockResponse),
        throwsA(isA<TypeError>()),
      );
    });
    test('correctly parses valid JSON for the products response', () {
      // Arrange
      // Mock the API response
      final mockResponse = {
        'id': 1,
        'title': 'Product 1',
        'price': 10.0,
        'description': 'Description 1',
        'category': 'category 1',
        'image': 'image1',
      };

      //  Act
      final product = ProductsFakeStore.fromJson(mockResponse);
      // Assert
      expect(product.id, 1);
      expect(product.title, 'Product 1');
      expect(product.price, 10.0);
      expect(product.description, 'Description 1');
      expect(product.category, 'category 1');
      expect(product.image, 'image1');
    });

    test('throws TypeError with invalid JSON for the user response', () {
      // Arrange
      // Mock the API response
      final mockResponse = {
        'addresss': {
          'city': 'City',
          'street': 'Street',
          'number': 123,
          'zipcode': '12345',
        },
        'ids': 1,
        'emails': 'email@gmail.com',
        'usernames': 'username',
        'passwords': 'password',
        'names': {'firstnames': 'firstname', 'lastnames': 'lastname'},
        'phones': '633554556',
      };
      //Assert
      expect(
        () => UsersFakeStore.fromJson(mockResponse),
        throwsA(isA<TypeError>()),
      );
    });
    test('correctly parses valid JSON for the user response', () {
      // Arrange
      // Mock the API response
      final mockResponse = {
        'address': {
          'city': 'City',
          'street': 'Street',
          'number': 123,
          'zipcode': '12345',
        },
        'id': 1,
        'email': 'email@gmail.com',
        'username': 'username',
        'password': 'password',
        'name': {'firstname': 'firstname', 'lastname': 'lastname'},
        'phone': '633554556',
      };
      //Act
      final user = UsersFakeStore.fromJson(mockResponse);
      //Assert
      //Address
      expect(user.apiAddress.city, 'City');
      expect(user.apiAddress.street, 'Street');
      expect(user.apiAddress.number, 123);
      expect(user.apiAddress.zipcode, '12345');
      //name
      expect(user.apiName.lastname, 'lastname');
      expect(user.apiName.firstname, 'firstname');
      //user
      expect(user.id, 1);
      expect(user.email, 'email@gmail.com');
      expect(user.username, 'username');
      expect(user.password, 'password');
      expect(user.phone, '633554556');
    });
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
      expect(carts.id, 1);
      expect(carts.userId, 1);
      expect(carts.productsId.map((item) => item.productId).toList(), [
        1,
        2,
        3,
      ]);
    });
  });
  test('throws TypeError with invalid JSON for the auth response', () {
    // Arrange
    // Mock the API response
    final mockResponse = {'tokens': 'token'};
    //Assert
    expect(
      () => TokenFakeStore.fromJson(mockResponse),
      throwsA(isA<TypeError>()),
    );
  });
  test('correctly parses valid JSON for the cart response', () {
    // Arrange
    // Mock the API response
    final mockResponse = {'token': 'token'};
    //Act
    final auth = TokenFakeStore.fromJson(mockResponse);
    //Assert
    expect(auth.token, 'token');
  });
}
