import 'dart:convert';
import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';

class TestObjects {
  static String get mockJsonProducts => '''
  [
    {
      "id": 1,
      "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      "price": 109.95,
      "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      "rating": {
        "rate": 3.9,
        "count": 120
      }
    },
    {
      "id": 2,
      "title": "Mens Casual Premium Slim Fit T-Shirts ",
      "price": 22.3,
      "description": "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
      "rating": {
        "rate": 4.1,
        "count": 259
      }
    }
  ]
  ''';

  static String get mockJsonUsers => '''
  [
    {
        "address": {
            "geolocation": {
                "lat": "-37.3159",
                "long": "81.1496"
            },
            "city": "kilcoole",
            "street": "new road",
            "number": 7682,
            "zipcode": "12926-3874"
        },
        "id": 1,
        "email": "john@gmail.com",
        "username": "johnd",
        "password": "m38rmF",
        "name": {
            "firstname": "john",
            "lastname": "doe"
        },
        "phone": "1-570-236-7033",
        "__v": 0
    },
    {
        "address": {
            "geolocation": {
                "lat": "-37.3159",
                "long": "81.1496"
            },
            "city": "kilcoole",
            "street": "Lovers Ln",
            "number": 7267,
            "zipcode": "12926-3874"
        },
        "id": 2,
        "email": "morrison@gmail.com",
        "username": "mor_2314",
        "password": "83r5^_",
        "name": {
            "firstname": "david",
            "lastname": "morrison"
        },
        "phone": "1-570-236-7033",
        "__v": 0
    }
  ]
  ''';

  static String get mockJsonCart => '''
  [
    {
        "id": 1,
        "userId": 1,
        "date": "2020-03-02T00:00:00.000Z",
        "products": [
            {
                "productId": 1,
                "quantity": 4
            },
            {
                "productId": 2,
                "quantity": 1
            },
            {
                "productId": 3,
                "quantity": 6
            }
        ],
        "__v": 0
    },
    {
        "id": 2,
        "userId": 1,
        "date": "2020-01-02T00:00:00.000Z",
        "products": [
            {
                "productId": 2,
                "quantity": 4
            },
            {
                "productId": 1,
                "quantity": 10
            },
            {
                "productId": 5,
                "quantity": 2
            }
        ],
        "__v": 0
    }
  ]
  ''';

  static get mockJsonAuth => '''
    {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    }
''';

  static List<T> _parseMockList<T>(
    String jsonStr,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList.map((json) => fromJson(json)).toList();
  }

  List<ProductsFakeStore> parseMockProducts() =>
      _parseMockList(mockJsonProducts, ProductsFakeStore.fromJson);

  List<UsersFakeStore> parseMockUsers() =>
      _parseMockList(mockJsonUsers, UsersFakeStore.fromJson);

  List<CartsFakeStore> parseMockCarts() =>
      _parseMockList(mockJsonCart, CartsFakeStore.fromJson);

  TokenFakeStore parseMockAuth() {
    final Map<String, dynamic> jsonMap = jsonDecode(mockJsonAuth);
    return TokenFakeStore.fromJson(jsonMap);
  }
}
