import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:simform_kaival/src/utils/constants/constants.dart';

class Api {
  final dio = createDio();
  static String BASE_URL = "https://randomuser.me/api/?results=5";
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 30000,
      //20 secs
      receiveTimeout: 30000,
      //20 secs
      sendTimeout: 30000,
      //20secs
    ));
    dio.interceptors.addAll({ErrorInterceptor(dio)});
    return dio;
  }

  Future<Response> get({
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    return await dio.get(this.dio.options.baseUrl,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options,
        queryParameters: queryParameters);
  }
}

class ErrorInterceptor extends Interceptor {
  final Dio dio;

  ErrorInterceptor(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        throw ConnectionTimeOutException(err.requestOptions);
      case DioErrorType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioErrorType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioErrorType.response:
        logger.e("STATUS CODE : ${err.response?.statusCode}");
        log("${err.response?.data}");
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        // TODO: Handle this case.
        break;
      case DioErrorType.other:
        logger.e(err.message);
        throw NoInternetConnectionException(err.requestOptions);
    }
    return handler.next(err);
  }
}

class ConnectionTimeOutException extends DioError {
  ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection Timed out, Please try again';
  }
}

class SendTimeOutException extends DioError {
  SendTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Send Timed out, Please try again';
  }
}

class ReceiveTimeOutException extends DioError {
  ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Receive Timed out, Please try again';
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Internal server error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, try refreshing when available.';
  }
}
