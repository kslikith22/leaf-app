import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NODEAPI {
  final Dio _dio = Dio();

  NODEAPI() {
    _dio.options.baseUrl = 'https://leaf-user-api.onrender.com/api';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
