import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
    expect(auth, isA<TokenFakeStore>());
  });
}
