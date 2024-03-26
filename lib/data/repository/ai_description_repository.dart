import 'package:dio/dio.dart';
import 'package:leafapp/data/api/node_api.dart';
import 'package:leafapp/data/models/ai_model.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AIRespository {
  NODEAPI nodeapi = NODEAPI();
  final Prefernces preferences = Prefernces();

  Future<String> _getToken() async {
    await preferences.initializeSharedPrefernces();
    return preferences.getToken();
  }

  Future generateData({required String className}) async {
    String token = await _getToken();
    final response = await nodeapi.sendRequest.post(
      '/generate',
      data: {"class_name": className},
      options: Options(
        headers: {"authorization": token},
      ),
    );
    final jsonData = response.data;
    return AIModel.fromJson(jsonData);
  }
}
