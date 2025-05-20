import 'package:fake_store_api_package/infraestructure/helpers/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
