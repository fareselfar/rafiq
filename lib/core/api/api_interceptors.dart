// lib/core/api/api_interceptors.dart
// أضف ده على AuthInterceptor الموجود

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('📤 REQUEST[${options.method}] => ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '📥 RESPONSE[${response.statusCode}] => ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '❌ ERROR[${err.response?.statusCode}] => ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}

/// يقرأ الـ token من SharedPreferences ويحطه في كل request
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('🔑 Token attached');
    }

    super.onRequest(options, handler);
  }
}