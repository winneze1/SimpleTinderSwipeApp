

import 'package:dateapp/api/connector/connector.dart';
import '../result/error.dart';

class Result<T> {
  bool? isExpired;
  int? code;
  Error? error;
  T? data;

  bool isError() {
    if (code != ConnectorConstants.OK) {
      return true;
    }
    return false;
  }

  bool isSuccess() {
    if (code == ConnectorConstants.OK && isExpired == null) {
      return true;
    }
    return false;
  }

  bool isNull() {
    if(code == ConnectorConstants.NO_INTERNET
        && isExpired == null
        && data == null){
      return true;
    }
    return false;
  }


  @override
  String toString() {
    return 'isExpired $isExpired, Code $code, message $error, data $data';
  }
}
