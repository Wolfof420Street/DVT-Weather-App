import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    debugPrint(
      "┌------------------------------------------------------------------------------",
    );
    debugPrint('| Request: ${options.method} ${options.uri}');
    debugPrint('| Body: ${options.data.toString()}');
    debugPrint('| Headers:');
    options.headers.forEach((key, value) {
      debugPrint('|\t$key: $value');
    });
    debugPrint(
      "├------------------------------------------------------------------------------",
    );
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    print("| Response [code ${response.statusCode}]");
    print("| Body: ${response.data.toString()}");
    print(
      "└------------------------------------------------------------------------------",
    );
    handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    print("| Error: [code ${err.response?.statusCode ?? 0}]");
    print("| Error body: ${err.response.toString()}");
    print(
      "└------------------------------------------------------------------------------",
    );
    handler.next(err); //continue
  }
}