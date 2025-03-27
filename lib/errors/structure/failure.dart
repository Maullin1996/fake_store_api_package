import 'package:equatable/equatable.dart';

/// An abstract class that represents a general failure.
/// Extends [Equatable] to allow for value comparison.
abstract class Failure extends Equatable {
  /// The error message associated with the failure.
  final String message;

  /// The error object associated with the failure.
  final dynamic error;

  /// Creates a [Failure] instance with the given [message] and [error].
  const Failure(this.message, this.error);

  @override
  List<Object?> get props => [message, error];
}
