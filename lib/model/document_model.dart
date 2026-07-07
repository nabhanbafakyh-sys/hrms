class DocumentModel {
  final int? id;
  final int employee;

  final String documentName;
  final String documentType;

  final String? uploadedAt;

  DocumentModel({
    this.id,
    required this.employee,
    required this.documentName,
    required this.documentType,
    this.uploadedAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json["id"],
      employee: json["employee"],
      documentName: json["document_name"],
      documentType: json["document_type"],
      uploadedAt: json["uploaded_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employee": employee,
      "document_name": documentName,
      "document_type": documentType,
    };
  }
}