import 'package:logger/logger.dart';

final logger = Logger();

const String serverErrorMessage =
    "Request could not be granted, try again later";
const String networkErrorMessage =
    "Check your internet connection and try again";
const String timeOutError = 'Timeout, please try again!';
const String unknonError = "Error occured try again later";
const Duration dbTimeOut = Duration(seconds: 45);
const baseUrl = 'https://phinga.ng/api/v1';
const authenticateError = 'Unauthorized: Token expired';
