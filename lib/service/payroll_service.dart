import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hrms_app/core/network/dio_client.dart';
import 'package:hrms_app/model/pay_roll_model.dart';

class PayrollService {
  static const String endpoint = "/payrolls/";

  Future<List<PayrollModel>> getPayrolls() async {
    try {
      final response = await DioClient.dio.get(endpoint);

      if (response.statusCode == 200) {
        final List data = response.data["results"] ?? [];

        return data
            .map((e) => PayrollModel.fromJson(e))
            .toList();
      }

      throw Exception("Failed to load payrolls");
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(_handleError(e));
    }
  }

  Future<PayrollModel> getPayrollById(int id) async {
    try {
      final response = await DioClient.dio.get("$endpoint$id/");

      if (response.statusCode == 200) {
        return PayrollModel.fromJson(response.data);
      }

      throw Exception("Payroll not found");
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(_handleError(e));
    }
  }

  Future<void> createPayroll(Map<String, dynamic> data) async {
    try {
      debugPrint("PAYROLL DATA: $data");

      final response = await DioClient.dio.post(
        endpoint,
        data: data,
      );

      debugPrint(response.data.toString());
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(_handleError(e));
    }
  }

  Future<void> updatePayroll(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      await DioClient.dio.put(
        "$endpoint$id/",
        data: data,
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(_handleError(e));
    }
  }

  Future<void> deletePayroll(int id) async {
    try {
      await DioClient.dio.delete("$endpoint$id/");
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout.";

      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond.";

      case DioExceptionType.sendTimeout:
        return "Request timeout.";

      case DioExceptionType.badResponse:
        return e.response?.data["message"] ??
            "Server error.";

      case DioExceptionType.connectionError:
        return "No internet connection.";

      default:
        return "Something went wrong.";
    }
  }
}