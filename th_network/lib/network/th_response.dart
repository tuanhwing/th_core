
import 'package:dio/dio.dart';

import '../common/common.dart';

class THResponse<T> {
  THResponse({this.statusCode = 200, this.code, this.message, this.data});
  int? statusCode;
  int? code;
  String? message;
  T? data;

  factory THResponse.fromJson(Response? response) {
    if (response == null) return THResponse.systemError();
    try {
      return THResponse(
        statusCode: response.statusCode,
        code: response.data['code'],
        data: response.data['data'],
      );
    }
    catch (exception) {
      return THResponse.systemError(message: exception.toString());
    }
  }

  factory THResponse.systemError({String? message}) {
    return THResponse(
      code: THErrorCodeClient.systemError,
      message: message
    );
  }

  THResponse<Obj> clone<Obj>({Obj? data}) {
    return THResponse<Obj>(
      statusCode: statusCode,
      code: code,
      data: data,
      message: message
    );
  }
}