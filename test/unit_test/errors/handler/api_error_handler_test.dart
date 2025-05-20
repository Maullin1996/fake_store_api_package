import 'dart:io';

import 'package:fake_store_api_package/errors/handler/api_error_handler.dart';
import 'package:fake_store_api_package/errors/structure/fetch_fake_store_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final handler = ApiErrorHandler();
  test('handles FetchFakeStoreException as notFound', () {
    //Arrange
    final error = FetchFakeStoreException(
      message: "Item not found",
      error: FetchFakeStoreError.notFound,
    );

    //Act
    final result = handler.handle(error);
    //Assert
    expect(result.message, "Item not found");
    expect(result.error, FetchFakeStoreError.notFound);
  });
  test(
    'handles HandshakeException as networkError with certificate message',
    () {
      //Arrange
      final error = HandshakeException();

      //Act
      final result = handler.handle(error);
      //Assert
      expect(
        result.message,
        'Network security error: Unable to verify certificate',
      );
      expect(result.error, FetchFakeStoreError.networkError);
    },
  );
  test('handles SocketException as networkError with connection message', () {
    //Arrange
    final error = SocketException("Failed host lookup");

    //Act
    final result = handler.handle(error);

    //Assert
    expect(result.message, contains("Network connection error"));
    expect(result.message, contains("Failed host lookup"));
    expect(result.error, FetchFakeStoreError.networkError);
  });

  test('handles HttpException as networkError with HTTP message', () {
    //Arrange
    final error = HttpException("404 Not Found");

    //Act
    final result = handler.handle(error);

    //Assert
    expect(result.message, contains("404 Not Found"));
    expect(result.error, FetchFakeStoreError.networkError);
  });

  test('handles unknown exceptions as unKnown error', () {
    //Arrange
    final error = Exception("Something unexpected");

    //Act
    final result = handler.handle(error);

    //Assert
    expect(result.message, contains("Something unexpected"));
    expect(result.error, FetchFakeStoreError.unKnown);
  });
}
