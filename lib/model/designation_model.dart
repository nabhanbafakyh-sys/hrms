class DesignationModel {
  final int id;
  final String title;

  DesignationModel({
    required this.id,
    required this.title,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      id: json["id"],
      title: json["title"],
    );
  }
}