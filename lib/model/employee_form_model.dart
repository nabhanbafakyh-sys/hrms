class EmployeeFormModel {
  String? employeeCode;
  String? name;
  String? email;
  String? phone;
  String? address;

  DateTime? dateOfBirth;
  DateTime? joiningDate;

  String? salary;

  int? departmentId;
  int? designationId;
  int? reportingManagerId;

  String status;

  // Future fields
  String? contractType;
  String? contractStatus;
  DateTime? contractStartDate;
  DateTime? contractEndDate;

  String? workArea;
  String? shift;

  String? profileImage;

  String? wageType;
String? allowances;
String? deductions;
String? payrollRule;
bool overtime = false;


String? geoFence;
bool attendanceRequired = false;

String? skills;
String? passportNo;
String? aadhaarNo;
String? panNo;

  EmployeeFormModel({
    this.employeeCode,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.joiningDate,
    this.salary,
    this.departmentId,
    this.designationId,
    this.reportingManagerId,
    this.status = "Active",
    this.contractType,
    this.contractStatus,
    this.contractStartDate,
    this.contractEndDate,
    this.workArea,
    this.shift,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "employee_code": employeeCode,
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "date_of_birth":
          dateOfBirth?.toIso8601String().split("T").first,
      "salary": salary,
      "joining_date":
          joiningDate?.toIso8601String().split("T").first,
      "status": status,
      "department": departmentId,
      "designation": designationId,
      "reporting_manager": reportingManagerId,
    };
  }
}