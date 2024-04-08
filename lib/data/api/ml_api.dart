import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MLAPI {
  final Dio _dio = Dio();

  MLAPI() {
        _dio.options.baseUrl = 'http://10.0.2.2:5000';
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}
