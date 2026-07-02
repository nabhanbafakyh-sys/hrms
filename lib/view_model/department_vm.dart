import 'package:flutter/material.dart';
import 'package:hrms_app/model/departmet_model.dart';
import 'package:hrms_app/service/dptmnt_service.dart';

class DepartmentViewModel extends ChangeNotifier {
  final DepartmentService _service = DepartmentService();

  List<DepartmentModel> departments = [];

  bool isLoading = false;

  String? errorMessage;

  Future<void> getDepartments() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      departments = await _service.getDepartments();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}