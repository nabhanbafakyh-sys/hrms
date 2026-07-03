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
  String searchQuery = "";

  EmployeeModel? selectedEmployee;

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
    _applyFilters();
  }

  void searchEmployee(String query) {
    searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    filteredEmployees = employees.where((employee) {
      final matchesDepartment =
          selectedDepartment == "All Departments" ||
          employee.department.toString() == selectedDepartment;

      final matchesSearch = employee.name.toLowerCase().contains(searchQuery);

      return matchesDepartment && matchesSearch;
    }).toList();

    notifyListeners();
  }

  Future<void> getEmployeeById(int id) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      selectedEmployee = await _employeeService.getEmployeeById(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addEmployee(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      await _employeeService.addEmployee(data);

      await getEmployees();

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
