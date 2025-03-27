/// An enumeration of possible errors that can occur when fetching from the fake store.
enum FetchFakeStoreError {
  /// Indicates that the requested resource was not found.
  notFound,

  /// Indicates that there was a server error.
  serverError,

  /// Indicates an unknown error.
  unKnown,

  /// Indicate a prblem in the network conection
  networkError,
}

/// A class that represents an exception thrown when fetching from the fake store.
class FetchFakeStoreException implements Exception {
  /// The error message associated with the exception.
  final String message;

  /// The specific error type associated with the exception.
  final FetchFakeStoreError error;

  /// Creates a [FetchFakeStoreException] instance with the given [message] and [error].
  FetchFakeStoreException({required this.message, required this.error});

  @override
  String toString() => 'FetchFakeStoreException: $message';
}
