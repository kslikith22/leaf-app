import 'dart:convert';

import 'package:leafapp/data/api/node_api.dart';
import 'package:leafapp/data/models/user_model.dart';
import 'package:leafapp/data/api/ml_api.dart';

class AuthRepository {
  NODEAPI nodeapi = NODEAPI();

  Future userLogin({
    required String name,
    required String email,
    required String profilePicture,
  }) async {
    final response = await nodeapi.sendRequest.post('/login', data: {
      'name': name,
      'profile_picture': profilePicture,
      'email': email,
    });
    final Map<String, dynamic> jsonData = response.data;
    return AuthResponse.fromJson(jsonData);
  }

  Future verifyUser({required String token}) async {
    final response =
        await nodeapi.sendRequest.post('/verify', data: {'token': token});
    final Map<String, dynamic> jsonData = response.data;
    return AuthResponse.fromJson(jsonData);
  }
}
