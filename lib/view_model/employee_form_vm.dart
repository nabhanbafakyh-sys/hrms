import 'package:flutter/material.dart';
import 'package:hrms_app/model/employee_form_model.dart';

class EmployeeFormViewModel extends ChangeNotifier {
  final form = EmployeeFormModel();

  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();

  int currentStep = 0;

  /// ---------------- STEP ----------------

  void nextStep() {
    if (currentStep < 5) {
      currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  /// ---------------- FORM ----------------

  void setDepartment(int? id) {
    form.departmentId = id;
    notifyListeners();
  }

  void setDesignation(int? id) {
    form.designationId = id;
    notifyListeners();
  }

  void setReportingManager(int? id) {
    form.reportingManagerId = id;
    notifyListeners();
  }

  void setStatus(String value) {
    form.status = value;
    notifyListeners();
  }

  void setJoiningDate(DateTime date) {
    form.joiningDate = date;
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    form.dateOfBirth = date;
    notifyListeners();
  }

  /// Called before saving
  void prepareForm() {
    form.name = nameController.text.trim();
    form.email = emailController.text.trim();
    form.phone = phoneController.text.trim();
    form.address = addressController.text.trim();
    form.salary = salaryController.text.trim();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    salaryController.clear();

    form.employeeCode = null;
    form.name = null;
    form.email = null;
    form.phone = null;
    form.address = null;
    form.salary = null;
    form.departmentId = null;
    form.designationId = null;
    form.reportingManagerId = null;
    form.dateOfBirth = null;
    form.joiningDate = null;
    form.status = "Active";

    currentStep = 0;

    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    salaryController.dispose();
    super.dispose();
  }
}