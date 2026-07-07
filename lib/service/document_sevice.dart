import 'package:dio/dio.dart';
import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/document_model.dart';

class DocumentService {
  Future<List<DocumentModel>> getDocuments() async {
    final response = await DioClient.dio.get("/documents/");

    final List data = response.data["results"];

    return data.map((e) => DocumentModel.fromJson(e)).toList();
  }

  Future<void> uploadDocument(Map<String, dynamic> data) async {
  try {
    print("DOCUMENT DATA: $data");

    final response = await DioClient.dio.post(
      "/documents/",
      data: data,
    );

    print(response.data);
  } on DioException catch (e) {
    print("DOCUMENT STATUS: ${e.response?.statusCode}");
    print("DOCUMENT ERROR: ${e.response?.data}");
    rethrow;
  }
}

  Future<void> deleteDocument(int id) async {
    await DioClient.dio.delete(
      "/documents/$id/",
    );
  }
}