import 'dart:io';

abstract class ApiRequest {
  final String method;
  final String path;
  final Map<String, String> headers;
  final Map<String, String>? queryParameters;

  const ApiRequest({
    required this.method,
    required this.path,
    required this.headers,
    this.queryParameters,
  });
}

class JsonRequest extends ApiRequest {
  final Map<String, dynamic>? body;

  JsonRequest({
    required super.method,
    required super.path,
    required super.headers,
    super.queryParameters,
    this.body,
  });
}

class FileRequest extends ApiRequest {
  final Map<String, dynamic>? body;
  final Map<String, File> filesMap;

  FileRequest({
    required super.method,
    required super.path,
    required super.headers,
    required this.filesMap,
    this.body,
    super.queryParameters,
  });
}