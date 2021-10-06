import 'dart:convert';

import 'package:dateapp/api/result/result.dart';
import 'package:dateapp/config/config_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../result/error.dart';


class ConnectorConstants {
  /// Status is ok
  static const int OK = 200;

  /// Status is created
  static const int CREATED = 201;

  /// Status is accepted
  static const int ACCEPTED = 202;

  /// Token expire
  static const int EXPIRED = 401;

  /// Not found
  static const int NOT_FOUND = 404;

  /// Status is not internet
  static const int NO_INTERNET = -1;
}

class Connector {
  Dio? _dio;

  /// Singleton pattern
  Connector._privateConstructor() {
    BaseOptions options = new BaseOptions(
        baseUrl: ConfigUrl.instance.baseUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000);
    Map<String, dynamic> headers = Map();
    headers['Content-Type'] = 'application/json';
    options.headers = headers;
    _dio = Dio(options);
    _dio?.interceptors.add(LogInterceptor(responseBody: true));
  }

  static final Connector _instance = Connector._privateConstructor();

  static Connector get instance {
    return _instance;
  }

  /// Get connector
  Dio? getConnector({ String? baseUrl, Map<String, dynamic>? headers, Function? callback}) {
    /// Add header
    if (headers != null) {
      _dio!.options.headers = headers;
    }

    /// Add base url
    _dio!.options.baseUrl = baseUrl!;
    return _dio;
  }

  /// Handle error
  Result handleError(DioError e) {
    Result result = Result();
    print('my response ' + e.response.toString());
    if(e == null) {
      result.code = ConnectorConstants.NOT_FOUND;
      result.error = Error(error: result.data['error']);
    }
    return result;
  }
}
