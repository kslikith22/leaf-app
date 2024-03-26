import 'package:dio/dio.dart';
import 'package:leafapp/data/api/node_api.dart';
import 'package:leafapp/data/models/user_activity_model.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';

class UserActivityRepository {
  NODEAPI nodeapi = NODEAPI();

  final Prefernces preferences = Prefernces();

  Future<String> _getToken() async {
    await preferences.initializeSharedPrefernces();
    return preferences.getToken();
  }

  Future getUserActivity() async {
    String token = await _getToken();
    final response = await nodeapi.sendRequest.get(
      '/activity',
      options: Options(
        headers: {'authorization': token},
      ),
    );
    print(response);
    return UserActivityModel.fromJson(response.data);
  }

  Future postUserActivity({
    required String className,
    required String confidence,
    required String imageUrl,
    required String markedUrl,
    required String heatmapUrl,
    required String about,
    required String prevention,
  }) async {
    String token = await _getToken();
    await nodeapi.sendRequest.post(
      '/activity',
      data: {
        'className': className,
        'imageUrl': imageUrl,
        'confidence': confidence,
        'about': about,
        'prevention': prevention,
        'markedUrl': markedUrl,
        'heatmapUrl': heatmapUrl
      },
      options: Options(
        headers: {"authorization": token},
      ),
    );
    return;
  }
}
