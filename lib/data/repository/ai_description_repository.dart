import 'package:leafapp/data/api/node_api.dart';
import 'package:leafapp/data/models/ai_model.dart';

class AIRespository {
  NODEAPI nodeapi = NODEAPI();

  Future generateData({required String className}) async {
    final response = await nodeapi.sendRequest.post(
      '/generate',
      data: {"class_name": className},
    );
    final jsonData = response.data;
    return AIModel.fromJson(jsonData);
  }
}
