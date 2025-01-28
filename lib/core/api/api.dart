import 'package:demo/core/helper/metwork_manager.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();
  final NetworkManager _networkManager = NetworkManager();

  API() {
    _dio.options.baseUrl = "https://android.indianpayrollservice.com/qxbox/api/";
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      request: false,
      maxWidth: 60,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          await _networkManager.checkConnectivityBeforeRequest();
          return handler.next(options);
        } on NoInternetException catch (e) {
          return _handleConnectionError(options, handler);
        }
      },
    ));

    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<void> _handleConnectionError(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool retrySuccessful = await _retryConnection();
    if (retrySuccessful) {
      return handler.next(options);
    } else {
      return handler.reject(DioException(
        type: DioExceptionType.connectionError,
        error: "Connection failed after retry",
        message: "Please check your internet connection.",
        requestOptions: options,
      ));
    }
  }

  Future<bool> _retryConnection() async {
    for (int i = 0; i < 3; i++) {
      try {
        await _networkManager.checkConnectivityBeforeRequest();
        return true;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    return false;
  }

  Dio get sendRequest => _dio;
}
