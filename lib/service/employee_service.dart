import 'package:dio/dio.dart';
import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/employee_model.dart';

class EmployeeService {
  Future<List<EmployeeModel>> getEmployees() async {
    List<EmployeeModel> employees = [];

    String? url = "/employees/";

    while (url != null) {
      print("GET URL: $url");
      final response = await DioClient.dio.get(url);
      print("TOTAL COUNT: ${response.data["count"]}");
      final List data = response.data["results"];

      employees.addAll(data.map((e) => EmployeeModel.fromJson(e)).toList());

      final String? next = response.data["next"];

      if (next != null) {
        url = next.replaceFirst(
          "https://employee-management-api-sigma.vercel.app/api",
          "",
        );
      } else {
        url = null;
      }
    }

    print("TOTAL LOADED: ${employees.length}");

    return employees;
  }

  Future<EmployeeModel> getEmployeeById(int id) async {
    final response = await DioClient.dio.get("/employees/$id/");

    return EmployeeModel.fromJson(response.data);
  }

  Future<EmployeeModel> addEmployee(Map<String, dynamic> data) async {
  try {
    print("EMPLOYEE DATA: $data");

    final response = await DioClient.dio.post(
      "/employees/",
      data: data,
    );

    print("STATUS: ${response.statusCode}");
    print("RESPONSE: ${response.data}");

    return EmployeeModel.fromJson(response.data);
  } on DioException catch (e) {
    print("STATUS: ${e.response?.statusCode}");
    print("ERROR: ${e.response?.data}");
    rethrow;
  }
}

  Future<void> updateEmployee(int id, Map<String, dynamic> data) async {
    try {
      print("UPDATE ID: $id");
      print("UPDATE DATA: $data");

      final response = await DioClient.dio.put("/employees/$id/", data: data);

      print("UPDATE RESPONSE: ${response.data}");
    } on DioException catch (e) {
      print("UPDATE STATUS: ${e.response?.statusCode}");
      print("UPDATE ERROR: ${e.response?.data}");
      rethrow;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      print("DELETE ID: $id");

      final response = await DioClient.dio.delete("/employees/$id/");

      print("DELETE SUCCESS: ${response.statusCode}");
    } on DioException catch (e) {
      print("DELETE STATUS: ${e.response?.statusCode}");
      print("DELETE ERROR: ${e.response?.data}");
      print("DELETE PATH: ${e.requestOptions.path}");
      rethrow;
    }
  }
}
