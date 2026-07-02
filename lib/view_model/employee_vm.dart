import 'package:flutter/material.dart';
import 'package:hrms_app/model/employee_model.dart';
import 'package:hrms_app/service/employee_service.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeService _employeeService = EmployeeService();

  List<EmployeeModel> employees = [];
  List<EmployeeModel> filteredEmployees = [];

  bool isLoading = false;
  String? errorMessage;

  String selectedDepartment = "All Departments";

  Future<void> getEmployees() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      employees = await _employeeService.getEmployees();

      filteredEmployees = employees;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterByDepartment(String department) {
    selectedDepartment = department;

    if (department == "All Departments") {
      filteredEmployees = employees;
    } else {
      filteredEmployees = employees.where((employee) {
        return employee.department.toString() == department;
      }).toList();
    }

    notifyListeners();
  }
}
