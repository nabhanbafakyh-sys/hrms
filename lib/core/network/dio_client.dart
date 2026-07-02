import 'package:dio/dio.dart';
import 'package:hrms_app/core/constants/api_const.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
}
