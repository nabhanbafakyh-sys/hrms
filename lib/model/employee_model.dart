class EmployeeModel {
  final int id;
  final String? employeeCode;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String dateOfBirth;
  final String salary;
  final String joiningDate;
  final bool isDeleted;
  final String status;
  final int department;
final int designation;
  final int? reportingManager;

  EmployeeModel({
    required this.id,
    required this.employeeCode,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.salary,
    required this.joiningDate,
    required this.isDeleted,
    required this.status,
    required this.department,
    required this.designation,
    required this.reportingManager,
  });
factory EmployeeModel.fromJson(Map<String, dynamic> json) {
  return EmployeeModel(
    id: json["id"],
    employeeCode: json["employee_code"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    dateOfBirth: json["date_of_birth"],
    salary: json["salary"],
    joiningDate: json["joining_date"],
    isDeleted: json["is_deleted"],
    status: json["status"],
    department: json["department"],
    designation: json["designation"],
    reportingManager: json["reporting_manager"],
  );
}
}
