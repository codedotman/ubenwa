import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ubenwa_cart/data/environment_configuration.dart';
import 'package:ubenwa_cart/data/exceptions.dart';
import 'package:ubenwa_cart/data/local/local_storage.dart';
import 'package:ubenwa_cart/data/local/storage_keys.dart';

Map<String, String> baseHeaders = {
  'Content-Type': 'application/vnd.api+json',
};

class HttpService {
  static String _url(String route) {
    return route.contains('://')
        ? route
        : '${EnvironmentConfiguration.BASE_API_URL}$route';
  }

  static Future<http.Response> getVerb(String route,
      {bool addAuthToken = true}) async {
    final url = _url(route);
    try {
      final headers = await _getHeaders(addAuthToken);
      final response = await http.get(Uri.parse(url), headers: headers);
      return response;
    } on SocketException {
      return http.Response(
          jsonEncode({
            "errors": [
              {"detail": "No Internet connection"}
            ]
          }),
          500);
    } on HttpException {
      return http.Response(
          jsonEncode({
            "errors": [
              {"detail": "Network Error"}
            ]
          }),
          500);
    } on FormatException {
      return http.Response(
          jsonEncode({
            "errors": [
              {"detail": "Bad response format"}
            ]
          }),
          500);
    }
  }

  static Future<dynamic> postVerb(
    String route, {
    dynamic body,
    bool addAuthToken = true,
  }) async {
    final url = _url(route);
    final headers = await _getHeaders(addAuthToken);

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      return response;
    } on SocketException {
      return http.Response(
          jsonEncode({
            {
              "errors": [
                {"detail": "No Internet connection"}
              ]
            }
          }),
          500);
    } on HttpException {
      return http.Response(
          jsonEncode({
            "errors": [
              {"detail": "Network Error"}
            ]
          }),
          500);
    } on FormatException {
      return http.Response(
          jsonEncode({
            "errors": [
              {"detail": "Bad response format"}
            ]
          }),
          500);
    }
  }

  static Future<Map<String, String>> _getHeaders(bool addAuthToken) async {
    var headers = {...baseHeaders};

    if (addAuthToken) {
      final token = await LocalStorage().read(StorageKeys.userToken);
      headers = {
        ...headers,
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return headers;
  }

  static dynamic parseResponse(http.Response response) async {
    Map<String, dynamic> responseBody = {};
    try {
      responseBody = json.decode(response.body);
    } catch (ex) {
      if (ex is FormatException) {
        return Future.error(BadFormatException());
      }
    }
    if (response.statusCode < 200 || response.statusCode >= 400) {
      switch (response.statusCode) {
        case 503:
          return Future.error(NotFoundException("Service unavailable", 0));
        default:
          return Future.error(BadRequestException(
              responseBody['errors'][0]['detail'],
              responseBody["internal_response_code"] ?? 0));
      }
    }
    return responseBody;
  }
}
