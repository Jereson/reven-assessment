import 'dart:core';
import 'package:raven_assessment/model/baseModel/failure.dart';

class ApiResponse<T> {
  final T? data;
  final Failure? error;
  final bool? hasError;

  ApiResponse({
    this.data,
    this.error = NullFailure.instance,
  })  : hasError = error != NullFailure(),
        assert((data != null) || (error != NullFailure()),
            'Must have one of data or error');
}

extension Converter<E> on ApiResponse<Map<String, dynamic>> {
  ApiResponse<E> transform<E>(
    E Function(Map<String, dynamic> data) transformer, {
    bool ignoreHasError = false,
  }) {
    E? transformedData;
    if (data != null) {
      transformedData =
          ((ignoreHasError || !hasError!) ? transformer(data!) : null);
    }

    return ApiResponse<E>(
      data: transformedData,
      error: error,
    );
  }

  ApiResponse<bool> transformToStatusOnly() {
    // final status = (data!['status'] == true);

    // return ApiResponse(
    //   data: status,
    //   error: error,
    // );
    return transform((data) {
      final status = data['status'] ?? data['success'] as bool;
      return status;
    });
  }
}
