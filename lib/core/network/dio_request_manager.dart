import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'i_api_request_manager.dart';

class DioRequestManager extends IApiRequestManager{
  static final _baseUrl = 'https://api1.binance.com';
  final _connectionTimeout = 50000;
  final _receiveTimeout = 30000;
  Dio _dio;

  DioRequestManager() {
    BaseOptions options = new BaseOptions(
      baseUrl: "$_baseUrl",
      connectTimeout: _connectionTimeout,
      receiveTimeout: _receiveTimeout,
    );
    _dio = new Dio(options);
    setInterceptor();
  }

  void setInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
            'accept-charset': 'UTF-8',
          };
          return options;
        },
        onResponse: (Response response) async {
          print('----->>> $response');
          return response;
        },
        onError: (DioError e) async {
          switch (e.type) {
            case DioErrorType.CONNECT_TIMEOUT:
              return DioError(
                request: e.request,
                response: e.response,
                error: "ارتباط اینترنت را بررسی کنید",//CONNECT_TIMEOUT
              );
              break;
            case DioErrorType.DEFAULT :
              return DioError(
                request: e.request,
                response: e.response,
                error: '${e.message}'//HandshakeException - SocketException //مشکل در برقراری اینترنت
              );
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              return DioError(
                request: e.request,
                response: e.response,
                error: "ارتباط اینترنت را بررسی کنید",// RECEIVE_TIMEOUT
              );
              break;

            case DioErrorType.CANCEL:
              return DioError(
                request: e.request,
                response: e.response,
                error: "",// CANCEL
              );
              break;

            case DioErrorType.SEND_TIMEOUT:
              return DioError(
                request: e.request,
                response: e.response,
                error: "ارتباط برقرار نشد",//Timeout
              );
              break;
            case DioErrorType.RESPONSE:
              return DioError(
                request: e.request,
                response: e.response,
                error: e.response.data["message"],
              );
              break;
          }
          return e;
        },
      ),
    );
  }

  @override
  Future<dynamic> getRequest({@required String path, Map<String, String> parameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: parameters);
      return response.data;
    } on DioError catch (e) {
      throw FormatException(e.message);
    }
  }

  @override
  Future<dynamic> postRequest({@required String path, Map<String, String> parameters, body}) async {
    try {
      final response = await _dio.post(path, data: body);
      print('------ $response');
      return response.data;
    } on DioError catch (e) {
      throw FormatException(e.message);
    }
  }








}
