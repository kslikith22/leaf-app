class AIModel {
  final String about;
  final String prevention;
  AIModel({required this.about, required this.prevention});

  factory AIModel.fromJson(Map<String, dynamic> jsonData) {
    return AIModel(
      about: jsonData['about'],
      prevention: jsonData['prevention'],
    );
  }
}
