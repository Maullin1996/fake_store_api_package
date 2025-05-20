import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/errors/index_errors.dart';
import 'package:fake_store_api_package/infraestructure/driven-adapter/api/fake_store_api.dart';
import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:http/testing.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  late FakeStoreApi fakeStoreApi;
  late MockClient mockClient;

  group('fetchProducts()', () {
    const mockJsonProducts = '''
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
      }
    ]
    ''';

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path == '/products') {
          return http.Response(mockJsonProducts, 200);
        } else if (request.url.path == '/produc') {
          return http.Response('Not Found', 500);
        }
        return http.Response('Not Found', 404);
      });

      fakeStoreApi = FakeStoreApi(
        baseUrl: ApiConfig.baseUrl,
        client: mockClient,
      );
    });

    test('returns list of products if call is successful', () async {
      final products = await fakeStoreApi.fetchProducts(ApiConfig.products);
      expect(products, isA<List<ProductsFakeStore>>());
      expect(products.length, 1);
      expect(products.first.id, 1);
    });

    test('throws exception if call fails', () async {
      expect(
        () async => await fakeStoreApi.fetchProducts('/produc'),
        throwsA(isA<FetchFakeStoreException>()),
      );
    });
  });

  group('fetchCart()', () {
    const mockJsonCarts = '''
    [
      {
        "id": 1,
        "userId": 1,
        "date": "2020-03-02T00:00:00.000Z",
        "products": [
          {"productId": 1, "quantity": 4},
          {"productId": 2, "quantity": 1},
          {"productId": 3, "quantity": 6}
        ],
        "__v": 0
      }
    ]
    ''';

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path == '/carts') {
          return http.Response(mockJsonCarts, 200);
        } else if (request.url.path == '/cart') {
          return http.Response('Not Found', 500);
        }
        return http.Response('Not Found', 404);
      });

      fakeStoreApi = FakeStoreApi(
        baseUrl: ApiConfig.baseUrl,
        client: mockClient,
      );
    });

    test('returns list of carts if call is successful', () async {
      final carts = await fakeStoreApi.fetchCart(ApiConfig.carts);
      expect(carts, isA<List<CartsFakeStore>>());
      expect(carts.length, 1);
      expect(carts.first.productsId.length, 3);
      expect(carts.first.productsId[1].productId, 2);
    });

    test('throws exception if call fails', () async {
      expect(
        () async => await fakeStoreApi.fetchCart('/cart'),
        throwsA(isA<FetchFakeStoreException>()),
      );
    });
  });

  group('fetchUsers()', () {
    const mockJsonUsers = '''
  [
    {
      "address": {
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
    }
  ]
''';
    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.path == '/users') {
          return http.Response(mockJsonUsers, 200);
        } else if (request.url.path == '/user') {
          return http.Response('Not Found', 500);
        }
        return http.Response('Not Found', 404);
      });
      fakeStoreApi = FakeStoreApi(
        baseUrl: ApiConfig.baseUrl,
        client: mockClient,
      );
    });

    test('returns list of users if call is successful', () async {
      final users = await fakeStoreApi.fetchUser(ApiConfig.users);
      expect(users, isA<List<UsersFakeStore>>());
      expect(users.length, 1);
      expect(users.first.email, "john@gmail.com");
      expect(users.first.apiAddress.zipcode, '12926-3874');
      expect(users.first.apiName.lastname, 'doe');
    });
    test('throws exception if call fails', () async {
      expect(
        () async => await fakeStoreApi.fetchUser('/user'),
        throwsA(isA<FetchFakeStoreException>()),
      );
    });
  });
}
