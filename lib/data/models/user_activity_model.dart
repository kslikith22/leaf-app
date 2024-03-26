class UserHistoryModel {
  final String id;
  final String userId;
  final String imageUrl;
  final String className;
  final num confidence;
  final String about;
  final String prevention;
  final String markedUrl;
  final String heatmapUrl;

  UserHistoryModel({
    required this.about,
    required this.className,
    required this.confidence,
    required this.heatmapUrl,
    required this.id,
    required this.imageUrl,
    required this.markedUrl,
    required this.prevention,
    required this.userId,
  });

  factory UserHistoryModel.fromJson(Map<String, dynamic> jsonData) {
    return UserHistoryModel(
      about: jsonData['about'] ?? '',
      className: jsonData['className'] ?? '',
      confidence: jsonData['confidence'] ?? '',
      heatmapUrl: jsonData['heatmapUrl'] ?? '',
      id: jsonData['_id'] ?? '',
      imageUrl: jsonData['imageUrl'] ?? '',
      markedUrl: jsonData['markedUrl'] ?? '',
      prevention: jsonData['prevention'] ?? '',
      userId: jsonData['userId'] ?? '',
    );
  }
}

class PieChartCountModel {
  final num aboutCount;
  final num imageUrlCount;
  final num classNameCount;

  PieChartCountModel({
    required this.aboutCount,
    required this.classNameCount,
    required this.imageUrlCount,
  });

  factory PieChartCountModel.fromJson(Map<String, dynamic> jsonData) {
    return PieChartCountModel(
      aboutCount: jsonData['aboutCount'],
      classNameCount: jsonData['imageUrlCount'],
      imageUrlCount: jsonData['imageUrlCount'],
    );
  }
}

class UserActivityModel {
  final List<UserHistoryModel> userHistoryModel;
  final PieChartCountModel pieChartCountModel;
  UserActivityModel({
    required this.userHistoryModel,
    required this.pieChartCountModel,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> jsonData) {
    print(jsonData['userActivities']); // Add this line for debugging
    return UserActivityModel(
      userHistoryModel: (jsonData['userActivities'] as List<dynamic>?)
              ?.map((history) => UserHistoryModel.fromJson(history))
              ?.toList() ??
          [],
      pieChartCountModel:
          PieChartCountModel.fromJson(jsonData['pieChartCounts']),
    );
  }
}
