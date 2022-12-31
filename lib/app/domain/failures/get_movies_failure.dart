import '../../../core/failures/failures.dart';

class EmptyFilterGetMoviesFailure extends Failure {
  EmptyFilterGetMoviesFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}
