import 'package:flutter/material.dart';
import 'package:hrms_app/model/document_model.dart';
import 'package:hrms_app/service/document_sevice.dart';

class DocumentViewModel extends ChangeNotifier {
  final DocumentService _service = DocumentService();

  List<DocumentModel> documents = [];

  bool isLoading = false;

  String? errorMessage;

  Future<void> getDocuments() async {
    try {
      isLoading = true;
      notifyListeners();

      documents = await _service.getDocuments();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> uploadDocument(
    Map<String, dynamic> data,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.uploadDocument(data);

      await getDocuments();

      return true;
    } catch (e) {
      errorMessage = e.toString();

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteDocument(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.deleteDocument(id);

      await getDocuments();

      return true;
    } catch (e) {
      errorMessage = e.toString();

      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}