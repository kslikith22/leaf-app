import 'package:leafapp/data/models/user_model.dart';
import 'package:leafapp/data/repository/api.dart';

class AuthRepository {
  API api = API();

  Future userLogin({
    required String name,
    required String image,
    required String email,
  }) async {
    final response = await api.sendRequest.post('/login', data: {
      'name': name,
      'profile_picture': image,
      'email': email,
    });
    final Map<String, dynamic> jsonData = response.data;
    print(response.data);
  }
}
