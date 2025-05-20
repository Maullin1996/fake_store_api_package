import 'package:dartz/dartz.dart';
import 'package:fake_store_api_package/config/constants/api_config.dart';
import 'package:fake_store_api_package/errors/index_errors.dart';
import 'package:fake_store_api_package/infraestructure/driven-adapter/index.dart';
import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:fake_store_api_package/methods/api_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_services_test.mocks.dart';
import 'test_objects.dart';

@GenerateMocks(
  [FakeStoreApi, AuthFakeStoreApi, ApiErrorHandler],
  customMocks: [
    MockSpec<FakeStoreApi>(as: #GeneratedMockFakeStoreApi),
    MockSpec<AuthFakeStoreApi>(as: #GeneratedMockAuthFakeStoreApi),
    MockSpec<ApiErrorHandler>(as: #GeneratedMockApiErrorHandler),
  ],
)
void main() {
  late ApiServices apiServices;
  late GeneratedMockFakeStoreApi mockFakeStoreApi;
  late GeneratedMockAuthFakeStoreApi mockAuthFakeStoreApi;
  late GeneratedMockApiErrorHandler mockApiErrorHandler;
  group('fetchProducts', () {
    setUp(() {
      mockFakeStoreApi = GeneratedMockFakeStoreApi();
      mockApiErrorHandler = GeneratedMockApiErrorHandler();
      apiServices = ApiServices(
        fakeStoreApi: mockFakeStoreApi,
        errorHandler: mockApiErrorHandler,
      );
    });
    test('Return a list of ProductsFakeStore if success', () async {
      //Arrange
      final expectedProducts = TestObjects().parseMockProducts();

      //Setup mock
      when(
        mockFakeStoreApi.fetchProducts(ApiConfig.products),
      ).thenAnswer((_) async => expectedProducts);

      // Act
      final result = await apiServices.fetchProducts();

      //Assert
      expect(result, isA<Right<Failure, List<ProductsFakeStore>>>());
      expect((result as Right).value, expectedProducts);
      verify(mockFakeStoreApi.fetchProducts(ApiConfig.products)).called(1);

      // Extract and verify the value
      result.fold(
        (failure) => fail('Expected Right, but got Left: $failure'),
        (products) => expect(products, expectedProducts),
      );
    });
    test('returns a Left with the exception if an error occurs', () async {
      //Arrange
      final expectedException = FetchFakeStoreException(
        message: 'API request failed',
        error: FetchFakeStoreError.notFound,
      );
      final expectedFailure = ApiFailure.fromException(expectedException);
      // Setup mock to throw an exception
      when(
        mockFakeStoreApi.fetchProducts(ApiConfig.products),
      ).thenThrow(expectedException);

      // Setup error handler to return the same exception
      when(mockApiErrorHandler.handle(any)).thenReturn(expectedFailure);
      // Act
      final result = await apiServices.fetchProducts();
      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, equals(expectedFailure));
      }, (_) => fail('Expected Left but got Right'));
    });
  });

  group('fetchUsers', () {
    setUp(() {
      mockFakeStoreApi = GeneratedMockFakeStoreApi();
      mockApiErrorHandler = GeneratedMockApiErrorHandler();

      apiServices = ApiServices(
        fakeStoreApi: mockFakeStoreApi,
        errorHandler: mockApiErrorHandler,
      );
    });

    test('Return a list of UsersFakeStore if success', () async {
      //Arrange
      final expectedUsers = TestObjects().parseMockUsers();

      //SetUp mock
      when(
        mockFakeStoreApi.fetchUser(ApiConfig.users),
      ).thenAnswer((_) async => expectedUsers);

      // Act
      final result = await apiServices.fetchUsers();

      // Assert
      expect(result, isA<Right<Failure, List<UsersFakeStore>>>());
      expect((result as Right).value, expectedUsers);
      verify(mockFakeStoreApi.fetchUser(ApiConfig.users)).called(1);

      //Extract and verify the value
      result.fold(
        (failure) => fail('Expected Right, but got Left: $failure'),
        (users) => expect(users, expectedUsers),
      );
    });
    test('returns a Left with the exception if an error occurs', () async {
      //Arrange
      final expectedException = FetchFakeStoreException(
        message: 'API request failed',
        error: FetchFakeStoreError.notFound,
      );
      final expectedFailure = ApiFailure.fromException(expectedException);
      // Setup mock to throw an exception
      when(
        mockFakeStoreApi.fetchUser(ApiConfig.users),
      ).thenThrow(expectedException);

      // Setup error handler to return the same exception
      when(mockApiErrorHandler.handle(any)).thenReturn(expectedFailure);

      //Act
      final result = await apiServices.fetchUsers();

      //Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, equals(expectedFailure)),
        (_) => fail('Expected Left but got Right'),
      );
    });
  });

  group('fetchCarts', () {
    setUp(() {
      mockFakeStoreApi = GeneratedMockFakeStoreApi();
      mockApiErrorHandler = GeneratedMockApiErrorHandler();
      apiServices = ApiServices(
        fakeStoreApi: mockFakeStoreApi,
        errorHandler: mockApiErrorHandler,
      );
    });
    test('Return a list of CartsFakeStore if success', () async {
      // Arrange
      final expectedCarts = TestObjects().parseMockCarts();

      //Setup mock
      when(
        mockFakeStoreApi.fetchCart(ApiConfig.carts),
      ).thenAnswer((_) async => expectedCarts);

      // Act
      final result = await apiServices.fetchCarts();

      // Assert
      expect(result, isA<Right<Failure, List<CartsFakeStore>>>());
      expect((result as Right).value, expectedCarts);
      verify(mockFakeStoreApi.fetchCart(ApiConfig.carts)).called(1);

      // Extract and verify the value
      result.fold(
        (failure) => fail('Expected Right, but got Left: $failure'),
        (carts) => expect(carts, expectedCarts),
      );
    });
    test('returns a Left with the exception if an error occurs', () async {
      //Arrange
      final expectedException = FetchFakeStoreException(
        message: 'API request failed',
        error: FetchFakeStoreError.notFound,
      );
      final expectedFailure = ApiFailure.fromException(expectedException);
      // Setup mock to throw an exception
      when(
        mockFakeStoreApi.fetchCart(ApiConfig.carts),
      ).thenThrow(expectedException);
      // Setup error handler to return the same exception
      when(mockApiErrorHandler.handle(any)).thenReturn(expectedFailure);
      // Act
      final result = await apiServices.fetchCarts();
      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, equals(expectedFailure)),
        (_) => fail('Expected Left but got Right'),
      );
    });
  });
  group('fetchAuth', () {
    setUp(() {
      mockAuthFakeStoreApi = GeneratedMockAuthFakeStoreApi();
      mockApiErrorHandler = GeneratedMockApiErrorHandler();
      apiServices = ApiServices(
        authFakeStoreApi: mockAuthFakeStoreApi,
        errorHandler: mockApiErrorHandler,
      );
    });
    test('Return a token if success', () async {
      //Arrange
      final expectedToken = TestObjects().parseMockAuth();

      //Setup mock
      when(
        mockAuthFakeStoreApi.authentication(
          username: 'kateh',
          password: 'kfejk@*',
        ),
      ).thenAnswer((_) async => expectedToken);

      // Act
      final result = await apiServices.fetchAuth(
        username: 'kateh',
        password: 'kfejk@*',
      );

      //Assert
      expect(result, isA<Right<Failure, TokenFakeStore>>());
      //verify the token.
      result.fold(
        (failure) => fail('Expected Right, but got Left: $failure'),
        (token) => expect(token.token, expectedToken.token),
      );
    });
    test('returns a Left with the exception if an error occurs', () async {
      //Arrange
      final expectedException = FetchFakeStoreException(
        message: 'API request failed',
        error: FetchFakeStoreError.notFound,
      );
      final expectedFailure = ApiFailure.fromException(expectedException);
      // SetUp mock to throw an exception
      when(
        mockAuthFakeStoreApi.authentication(
          username: 'kateh',
          password: 'kfejk@*',
        ),
      ).thenThrow(expectedException);

      // Setup error handler to return the same exception
      when(mockApiErrorHandler.handle(any)).thenReturn(expectedFailure);

      // Act
      final result = await apiServices.fetchAuth(
        username: 'kateh',
        password: 'kfejk@*',
      );

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, equals(expectedFailure)),
        (_) => fail('Expected Left but got Right'),
      );
    });
  });
}
