class UserModel {
  final String name;
  final String email;
  final String profilePhoto;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.token,
  });

  factory UserModel.toJson(Map<String, dynamic> jsonData) {
    return UserModel(
        name: jsonData['name'],
        email: jsonData['email'],
        profilePhoto: jsonData['profile_picture'],
        token: jsonData['access_token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_picture': profilePhoto,
      'access_token': token
    };
  }
}
