class LeafModel {
  final num confidence;
  final String className;
  final String imageUrl;
  final String markedUrl;
  final String heatmapUrl;

  LeafModel({
    required this.className,
    required this.confidence,
    required this.heatmapUrl,
    required this.imageUrl,
    required this.markedUrl,
  });

  factory LeafModel.fromJson(Map<String, dynamic> json) {
    return LeafModel(
      className: json['class_name'],
      confidence: json['confidence'],
      imageUrl: json['imageUrl'],
      markedUrl: json['markedUrl'],
      heatmapUrl: json['heatmapUrl']
    );
  }
}
