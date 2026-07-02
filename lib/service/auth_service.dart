import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/login_request_model.dart';
import 'package:hrms_app/model/login_response_model.dart';

class AuthService {
  Future<LoginResponseModel> login({required LoginRequestModel request}) async {
    final response = await DioClient.dio.post(
      "/users/login/",
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
