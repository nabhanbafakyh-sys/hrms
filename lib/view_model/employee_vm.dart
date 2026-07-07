import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/employee_model.dart';
import 'package:hrms_app/service/employee_service.dart';

class EmployeeViewModel extends ChangeNotifier {
  final EmployeeService _employeeService = EmployeeService();

  //--------------------------------------------------
  // STATE
  //--------------------------------------------------

  List<EmployeeModel> employees = [];

  List<EmployeeModel> filteredEmployees = [];

  EmployeeModel? selectedEmployee;

  bool isLoading = false;

  String? errorMessage;

  int totalEmployees = 0;
  String? nameError;
  String? emailError;
  String? phoneError;
  String? salaryError;
  String? departmentError;
  String? designationError;

  void clearFieldErrors() {
    nameError = null;
    emailError = null;
    phoneError = null;
    salaryError = null;
    departmentError = null;
    designationError = null;
  }

  String searchQuery = "";

  String selectedDepartment = "All Departments";

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    errorMessage = value;
    notifyListeners();
  }

  Future<void> getEmployees() async {
    try {
      setLoading(true);
      setError(null);
      employees = await _employeeService.getEmployees();
      filteredEmployees = List.from(employees);
      totalEmployees = employees.length;
    } on DioException catch (e) {
      errorMessage = e.response?.data.toString() ?? e.message;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> getEmployeeById(int id) async {
    try {
      setLoading(true);
      selectedEmployee = await _employeeService.getEmployeeById(id);
    } on DioException catch (e) {
      errorMessage = e.response?.data.toString() ?? e.message;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setLoading(false);
    }
  }

  void searchEmployee(String query) {
    searchQuery = query.toLowerCase().trim();
    _applyFilters();
  }

  void filterByDepartment(String department) {
    selectedDepartment = department;
    _applyFilters();
  }

  void _applyFilters() {
    filteredEmployees = employees.where((employee) {
      final matchesDepartment =
          selectedDepartment == "All Departments" ||
          employee.department.toString() == selectedDepartment;

      final matchesSearch =
          employee.name.toLowerCase().contains(searchQuery) ||
          employee.email.toLowerCase().contains(searchQuery) ||
          employee.phone.contains(searchQuery);

      return matchesDepartment && matchesSearch;
    }).toList();
    notifyListeners();
  }

  String? getError(Map<String, dynamic> errors, String key) {
    if (!errors.containsKey(key)) {
      return null;
    }
    final value = errors[key];
    if (value is List && value.isNotEmpty) {
      return value.first.toString();
    }
    return value?.toString();
  }

  Future<EmployeeModel?> addEmployee(Map<String, dynamic> data) async {
    try {
      setLoading(true);
      setError(null);
      clearFieldErrors();
      final employee = await _employeeService.addEmployee(data);
      employees.add(employee);
      totalEmployees = employees.length;
      _applyFilters();
      return employee;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 &&
          e.response?.data is Map<String, dynamic>) {
        final errors = e.response!.data as Map<String, dynamic>;
        nameError = getError(errors, "name");
        emailError = getError(errors, "email");
        phoneError = getError(errors, "phone");
        salaryError = getError(errors, "salary");
        departmentError = getError(errors, "department");
        designationError = getError(errors, "designation");
        notifyListeners();
      } else {
        errorMessage =
            e.response?.data.toString() ?? e.message ?? "Something went wrong";
      }
      return null;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> updateEmployee(int id, Map<String, dynamic> data) async {
    try {
      setLoading(true);
      setError(null);
      await _employeeService.updateEmployee(id, data);
      await getEmployees();
      return true;
    } on DioException catch (e) {
      errorMessage = e.response?.data.toString() ?? e.message;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> deleteEmployee(int id) async {
    try {
      setLoading(true);
      setError(null);
      await _employeeService.deleteEmployee(id);
      employees.removeWhere((employee) => employee.id == id);
      totalEmployees = employees.length;
      _applyFilters();

      return true;
    } on DioException catch (e) {
      errorMessage = e.response?.data.toString() ?? e.message;

      return false;
    } catch (e) {
      errorMessage = e.toString();

      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> refreshEmployees() async {
    await getEmployees();
  }

  void clearSelection() {
    selectedEmployee = null;
    notifyListeners();
  }


  int get employeeCount => employees.length;

  int get activeEmployeeCount =>
      employees.where((e) => e.status.toLowerCase() == "active").length;

  int get inactiveEmployeeCount =>
      employees.where((e) => e.status.toLowerCase() != "active").length;



  bool get hasEmployees => employees.isNotEmpty;

  bool get hasSelectedEmployee => selectedEmployee != null;

  EmployeeModel? findEmployeeById(int id) {
    try {
      return employees.firstWhere((employee) => employee.id == id);
    } catch (_) {
      return null;
    }
  }


  void clearData() {
    employees.clear();
    filteredEmployees.clear();
    clearFieldErrors();
    selectedEmployee = null;
    totalEmployees = 0;
    searchQuery = "";
    selectedDepartment = "All Departments";
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
