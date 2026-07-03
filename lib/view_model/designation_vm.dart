import 'package:flutter/material.dart';
import 'package:hrms_app/model/designation_model.dart';
import 'package:hrms_app/service/designation_service.dart';


class DesignationViewModel extends ChangeNotifier {
  final DesignationService _service = DesignationService();

  List<DesignationModel> designations = [];

  bool isLoading = false;

  String? errorMessage;

  Future<void> getDesignations() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      designations = await _service.getDesignations();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  String getDesignationTitle(int id) {
  try {
    return designations.firstWhere((e) => e.id == id).title;
  } catch (e) {
    return "Unknown";
  }
}
}