import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/model/pay_roll_model.dart';
import 'package:hrms_app/service/payroll_service.dart';

class PayrollViewModel extends ChangeNotifier {
  final PayrollService _service = PayrollService();



  List<PayrollModel> payrolls = [];

  PayrollModel? selectedPayroll;

  bool isLoading = false;

  String? errorMessage;

  bool get hasPayrolls => payrolls.isNotEmpty;

  bool get hasError => errorMessage != null;

  int get totalPayrolls => payrolls.length;

  void _startLoading() {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
  }

  void _stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void selectPayroll(PayrollModel payroll) {
    selectedPayroll = payroll;
    notifyListeners();
  }

  void clearSelectedPayroll() {
    selectedPayroll = null;
    notifyListeners();
  }

  Future<void> getPayrolls() async {
    try {
      _startLoading();

      payrolls = await _service.getPayrolls();
    } catch (e) {
      debugPrint(e.toString());
      errorMessage = "Failed to load payrolls.";
    } finally {
      _stopLoading();
    }
  }

  Future<void> refreshPayrolls() async {
    await getPayrolls();
  }

  Future<bool> createPayroll(Map<String, dynamic> data) async {
    try {
      _startLoading();

      await _service.createPayroll(data);

      await getPayrolls();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      errorMessage = "Failed to create payroll.";
      return false;
    } finally {
      _stopLoading();
    }
  }

  Future<bool> updatePayroll(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      _startLoading();

      await _service.updatePayroll(id, data);

      await getPayrolls();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      errorMessage = "Failed to update payroll.";
      return false;
    } finally {
      _stopLoading();
    }
  }

  Future<bool> deletePayroll(int id) async {
    try {
      _startLoading();

      await _service.deletePayroll(id);

      payrolls.removeWhere((item) => item.id == id);

      if (selectedPayroll?.id == id) {
        selectedPayroll = null;
      }

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      errorMessage = "Failed to delete payroll.";
      return false;
    } finally {
      _stopLoading();
    }
  }
}