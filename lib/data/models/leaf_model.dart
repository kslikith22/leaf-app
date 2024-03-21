class LeafModel {
  final num confidence;
  final String className;

  LeafModel({required this.className, required this.confidence});

  factory LeafModel.fromJson(Map<String, dynamic> json) {
    return LeafModel(
      className: json['class_name'],
      confidence: json['confidence'],
    );
  }
}
