import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MLAPI {
  Dio _dio = Dio();

  MLAPI() {
    _dio.options.baseUrl = 'http://192.168.29.161:8080';
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}

final String predict = '/predict';
