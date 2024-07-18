import 'package:blog_application/core/failure/failure_message.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/exception.dart';

Future<Either<FailureMessage, T>> helperApiCall<T>({required Future<T> Function() apiCall}) async {
  try {
    final data = await apiCall();
    return right(data);
  } on AuthException catch (e) {
    return left(FailureMessage("Auth error: ${e.message}"));
  } on ServerException catch (e) {
    return left(FailureMessage("Server error: ${e.message}"));
  }
}
