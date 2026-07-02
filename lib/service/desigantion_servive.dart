import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/designation_model.dart';

class DesignationService {
  Future<List<DesignationModel>> getDesignations() async {
    final response = await DioClient.dio.get("/designations");

    final List data = response.data["results"];

    return data
        .map((designation) => DesignationModel.fromJson(designation))
        .toList();
  }
}