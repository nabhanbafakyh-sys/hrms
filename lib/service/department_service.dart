import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/department_model.dart';

class DepartmentService {
  Future<List<DepartmentModel>> getDepartments() async {
    final response = await DioClient.dio.get("/departments");

    final List data = response.data["results"];

    return data
        .map((department) => DepartmentModel.fromJson(department))
        .toList();
  }
}