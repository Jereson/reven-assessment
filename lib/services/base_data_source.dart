import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raven_assessment/model/baseModel/api_response.dart';
import 'package:raven_assessment/model/baseModel/failure.dart';
import 'package:raven_assessment/utilities/const_utils.dart';

class BaseDatasource {
  Uri _url(String endpoint) => Uri.parse('$baseUrl/$endpoint');

  Uri _urlWithQueryParams(String endpoint, Map<String, dynamic> queryParams) =>
      Uri.parse('$baseUrl/$endpoint');

  Map<String, String> get jsonHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  Future<ApiResponse<Map<String, dynamic>>> _processRequest(
    Future<http.Response> request,
  ) async {
    try {
      final response = await request.timeout(dbTimeOut,
          onTimeout: () => throw TimeoutException(serverErrorMessage));
      debugPrint('RESPONSE STATUS ---- ${response.statusCode}');
      debugPrint('RESPONSE BODY ---- ${response.body}');

      final unathorizeData = {'success': false, 'message': 'Unauthorized'};
      final data = response.statusCode == 401
          ? unathorizeData
          : jsonDecode(response.body);

      final error = _checkForError(response.statusCode, data);
      return ApiResponse(
        data: data,
        error: error,
      );
    } on FormatException {
      return ApiResponse(error: ServerFailure(error: serverErrorMessage));
    } catch (e) {
      return ApiResponse(error: convertException(e));
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> sendGet(
      {String? endpoint, Map<String, dynamic>? queryParams}) {
    final url = queryParams != null
        ? _urlWithQueryParams(endpoint!, queryParams)
        : _url(endpoint!);

    final request = http.get(
      url,
      headers: jsonHeaders,
    );
    debugPrint('REQUEST -- $url');
    return _processRequest(request);
  }

  Future<ApiResponse<Map<String, dynamic>>> sendPost({
    required String endpoint,
    String? payStackEndpoint,
    Map<String, dynamic>? payload,
  }) async {
    final url = _url(endpoint);
    final body = jsonEncode(payload);
    final request = http.post(url, body: body, headers: jsonHeaders);
    debugPrint('REQUEST -- $url -- $payload');
    return _processRequest(request);
  }

  Failure _checkForError(int statusCode, data) {
    String? returnedMessage;
    // returnedMessage = '';
    // if (statusCode - 200 <= 99) return NullFailure();
    if (data != null) {
      //Check if request was successful
      bool success = data['success'] ?? data['status'] ?? false;
      //If successful, return no failure
      // Null failure should be returned if success
      if (success) return NullFailure();
      final errors = data['message'] ?? data['errors'];
      //Check list of errors
      if (errors is String) {
        returnedMessage = errors;
      } else if (errors is Map) {
        //If no error field - use messsage for failure
        if (errors.isEmpty) {
          returnedMessage = data['message'];
        }
        //If there are error fields - use errors for failure
        else {
          // returnedMessage = errors;
          errors.forEach((key, value) {
            if (value is List) {
              returnedMessage = value.first;
            } else {
              returnedMessage = '$returnedMessage\n$value';
            }
          });
        }
      } else if (errors is List) {
        if (errors.isEmpty) {
          returnedMessage = null;
        } else {
          for (var value in errors) {
            if (value is String) {
              returnedMessage = value.toString();
            }
          }
        }
      }
    }

    returnedMessage ??= serverErrorMessage;
    logger.d('-----$returnedMessage-----');
    if (statusCode == 400) {
      return InputFailure(errorMessage: returnedMessage);
    } else if (statusCode == 401) {
      return UnthenticatedFailer(errorMessage: authenticateError);
    } else if (statusCode == 422) {
      return BadRequestFailure(errorMessage: returnedMessage);
    } else if (statusCode == 403) {
      return BadRequestFailure(errorMessage: returnedMessage);
    } else if (statusCode == 404) {
      return NotFoundFailure(errorMessage: returnedMessage);
    } else if (statusCode == 500) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 502) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 503) {
      return ServerFailure(error: returnedMessage);
    } else if (statusCode == 504) {
      return ServerFailure(error: returnedMessage);
    } else {
      return UnknownFailure(message: returnedMessage);
    }
  }
}
