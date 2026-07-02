import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/employee_model.dart';

class EmployeeService {
  Future<List<EmployeeModel>> getEmployees() async {
    final response = await DioClient.dio.get("/employees/");

    final List data = response.data["results"];

    return data
        .map((e) => EmployeeModel.fromJson(e))
        .toList();
  }
}
