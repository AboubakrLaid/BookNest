// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_books/api/api_request/api_request.dart';
import 'package:e_books/util/export.dart';

import '../services/connectivity.dart';

const String baseUrl = "192.168.1.41:8000";
const String GET = "GET";
const String POST = "POST";
const String PUT = "PUT";
const String DELETE = "DELETE";
const String PATCH = "PATCH";

abstract interface class RequestStrategy {
  Future<Map<String, dynamic>?> send({required ApiRequest apiRequest});
}

abstract interface class ApiInterface {
  Future<Map<String, dynamic>?> send({required ApiRequest apiRequest});
}

class Api implements ApiInterface {
  final RequestStrategy _requestStrategy;
  Api(this._requestStrategy);

  @override
  Future<Map<String, dynamic>?> send({required ApiRequest apiRequest}) async {
    try {
      // need to check the internet connection
      if (ConnectivityService.isDeviceConnected){
      final response = await _requestStrategy.send(apiRequest: apiRequest);
      return response;
      }else{
        return {
          "no-internet":true,
          "message":"no internet connection"
        };
      }
    } catch (e) {
      logger.e("exception from api: $e");
      return null;
    }
  }
}

class JsonRequestStrategy implements RequestStrategy {
  JsonRequestStrategy._();
  static final JsonRequestStrategy _instance = JsonRequestStrategy._();
  factory JsonRequestStrategy() => _instance;

  @override
  Future<Map<String, dynamic>?> send({required ApiRequest apiRequest}) async {
    try {
      final x = apiRequest as JsonRequest;

      final String method = x.method;
      final String path = x.path;
      final Map<String, String> headers = x.headers;

      final Map<String, dynamic>? body = x.body;
      final Map<String, String>? queryParameters = x.queryParameters;

      var url = "http://$baseUrl$path";

      final formData = body != null ? FormData.fromMap(body) : null;

      final dio = Dio();

      dio.options.validateStatus = (status) {
        return status! <= 500;
      };

      dio.options.headers = headers;
      if (queryParameters != null) {
        dio.options.queryParameters = queryParameters;
      }
      final response = await switch (method) {
        "GET" => dio.get(url),
        "POST" => dio.post(
            url,
            data: formData,
          ),
        "PUT" => dio.put(url, data: formData),
        "DELETE" => dio.delete(url, data: formData),
        "PATCH" => dio.patch(url, data: formData),
        String() => throw Exception("Invalid method $method"),
      };
      print("response: $response");

      final Map<String, dynamic>? data = response.data as Map<String, dynamic>?;
      data!["statusCode"] = response.statusCode;
      return data;
    } catch (e) {
      logger.e("exception from JsonRequestStrategy: $e");
      return {"error": "An error occurred"};
    }
  }
}

class MultipartRequestStrategy implements RequestStrategy {
  MultipartRequestStrategy._();
  static final MultipartRequestStrategy _instance =
      MultipartRequestStrategy._();
  factory MultipartRequestStrategy() => _instance;

  @override
  Future<Map<String, dynamic>?> send({required ApiRequest apiRequest}) async {
    try {
      final x = apiRequest as FileRequest;

      final String method = x.method;
      final String path = x.path;
      final Map<String, String> headers = x.headers;

      final Map<String, dynamic>? body = x.body;
      final Map<String, String>? queryParameters = x.queryParameters;
      final Map<String, File> filesMap = x.filesMap;

      final Map<String, MultipartFile> multipartFiles = {};
      for (var entry in filesMap.entries) {
        multipartFiles[entry.key] =
            await MultipartFile.fromFile(entry.value.path);
      }

      final String url = "http://$baseUrl$path";
      print("url: $url");

      final dio = Dio();

      dio.options.validateStatus = (status) {
        return status! <= 500;
      };

      final formData =
          FormData.fromMap({if (body != null) ...body, ...multipartFiles});

      dio.options.headers = headers;
      if (queryParameters != null) {
        dio.options.queryParameters = queryParameters;
      }

      final response = await switch (method) {
        "GET" => dio.get(url),
        "POST" => dio.post(
            url,
            data: formData,
          ),
        "PUT" => dio.put(url, data: formData),
        "DELETE" => dio.delete(url, data: formData),
        "PATCH" => dio.patch(url, data: formData),
        String() => throw Exception("Invalid method $method"),
      };
      print("response: $response");


      final Map<String, dynamic>? data = response.data as Map<String, dynamic>?;
      data!["statusCode"] = response.statusCode;

      return data;
    } catch (e) {
      logger.e("exception from MultipartRequestStrategy: $e");
      return {"error": "An error occurred"};
    }
  }
}


