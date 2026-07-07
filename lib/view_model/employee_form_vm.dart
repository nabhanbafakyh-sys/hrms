import 'package:flutter/material.dart';

class EmployeeFormViewModel extends ChangeNotifier {
  final personalFormKey = GlobalKey<FormState>();
  final jobFormKey = GlobalKey<FormState>();
  final contractFormKey = GlobalKey<FormState>();
  final payrollFormKey = GlobalKey<FormState>();
  final documentFormKey = GlobalKey<FormState>();

  int currentStep = 0;

  void nextStep() {
    currentStep++;
    notifyListeners();
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final salaryController = TextEditingController();
  final joiningController = TextEditingController();

  final allowanceController = TextEditingController();
  final deductionController = TextEditingController();

  final passportController = TextEditingController();
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();

  int? departmentId;
  int? designationId;
  int? reportingManagerId;

  String status = "Active";
  String paymentType = "Monthly";

  void setDepartment(int? value) {
    departmentId = value;
    notifyListeners();
  }

  void setDesignation(int? value) {
    designationId = value;
    notifyListeners();
  }

  void setReportingManager(int? value) {
    reportingManagerId = value;
    notifyListeners();
  }

  void setStatus(String? value) {
    if (value == null) return;

    status = value;
    notifyListeners();
  }
    bool validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return personalFormKey.currentState?.validate() ?? false;

      case 1:
        return jobFormKey.currentState?.validate() ?? false;

      case 2:
        return contractFormKey.currentState?.validate() ?? true;

      case 3:
        return payrollFormKey.currentState?.validate() ?? true;

      case 4:
        return documentFormKey.currentState?.validate() ?? true;

      default:
        return true;
    }
  }

  Map<String, dynamic> toEmployeeJson() {
    return {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "address": addressController.text.trim(),
      "date_of_birth": dobController.text.trim(),
      "salary": salaryController.text.trim(),
      "joining_date": joiningController.text.trim(),
      "status": status,
      "department": departmentId,
      "designation": designationId,
      "reporting_manager": reportingManagerId,
    };
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    dobController.clear();

    salaryController.clear();
    joiningController.clear();

    allowanceController.clear();
    deductionController.clear();

    passportController.clear();
    aadhaarController.clear();
    panController.clear();

    departmentId = null;
    designationId = null;
    reportingManagerId = null;

    status = "Active";
    paymentType = "Monthly";

    currentStep = 0;

    notifyListeners();
  }

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Name is required";
  }

  if (value.trim().length < 3) {
    return "Name must be at least 3 characters";
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Email is required";
  }

  if (!value.contains("@") || !value.contains(".")) {
    return "Enter a valid email";
  }

  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Phone number is required";
  }

  if (value.trim().length != 10) {
    return "Phone number must contain 10 digits";
  }

  if (int.tryParse(value.trim()) == null) {
    return "Phone number should contain only numbers";
  }

  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Address is required";
  }

  return null;
}

String? validateSalary(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Salary is required";
  }

  if (double.tryParse(value.trim()) == null) {
    return "Enter a valid salary";
  }

  return null;
}
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dobController.dispose();

    salaryController.dispose();
    joiningController.dispose();

    allowanceController.dispose();
    deductionController.dispose();

    passportController.dispose();
    aadhaarController.dispose();
    panController.dispose();

    super.dispose();
  }
}