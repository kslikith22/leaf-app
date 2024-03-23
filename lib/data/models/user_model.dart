import 'dart:convert';

class AuthResponse {
  final String status;
  final User user;
  final String token;

  AuthResponse({
    required this.status,
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'],
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

