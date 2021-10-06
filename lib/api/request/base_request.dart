import 'dart:async';
import 'dart:isolate';

import 'package:dateapp/api/params/params.dart';
import 'package:dateapp/api/result/result.dart';
import 'package:dateapp/config/config_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class BaseRequestConstants {
  static const String APP_ID = 'app-id';
}

abstract class BaseRequest {
  /// Status is ok
  static const int OK = 200;

  /// Status is created
  static const int CREATED = 201;

  /// Status is accepted
  static const int ACCEPTED = 202;

  /// Token expire
  static const int EXPIRE = 401;

  /// Status is not internet
  static const int NO_INTERNET = -1;

  /// Status is no concurrent
  static const int NO_CONCURRENT = -2;

  /// Status is calling API.
  bool isCalling = false;

  /// Params
  Params? params;



  /// Get headers
  Future<Map<String, dynamic>> getHeaders() async {
    String appId = '615d98d06a7786eee6224099';
    Map<String, dynamic> headers = Map();
    headers[BaseRequestConstants.APP_ID] = appId;
    return headers;
  }

  /// Call request
  Future<Result> callRequest(BuildContext context,
      {Map<String, dynamic>? queries,
        Map<String, dynamic>? data,
        List<String>? paths,
        Map<String, dynamic>? headers}) async {
    /// Get header
    Map<String, dynamic> headersValue = Map();
    if (headers == null) {
      headersValue = await getHeaders();
    } else {
      headersValue = headers;
    }


    /// Get base url
    String baseUrl = ConfigUrl.instance.baseUrl;

    params = Params(
        baseUrl: baseUrl, headers: headersValue, queries: queries, data: data, paths: paths);

    Result result = await handleRequest(context);

    return result;
  }

  /// Handle request
  Future<Result> handleRequest(BuildContext context);


}