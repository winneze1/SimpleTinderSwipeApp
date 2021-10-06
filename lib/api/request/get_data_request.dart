import 'package:dateapp/api/connector/connector.dart';
import 'package:dateapp/api/result/result.dart';
import 'package:dateapp/api/result/user_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'base_request.dart';

class GetUserList extends BaseRequest {
  @override
  Future<Result> handleRequest(BuildContext context) async {
    Result result;
    try {
      /// Get connector
      Dio? connector = Connector.instance
          .getConnector(baseUrl: params!.baseUrl, headers: params!.headers);

      /// Call API
      int limit = params!.queries!['limit'];
      Response response = await connector!.get('/user?limit=$limit');
      result = Result<UserList>();
      result.code = response.statusCode;
      result.data = UserList.fromJson(response.data);
    } on DioError catch (e) {
      result = Connector.instance.handleError(e);
    }
    return result;
  }
}
