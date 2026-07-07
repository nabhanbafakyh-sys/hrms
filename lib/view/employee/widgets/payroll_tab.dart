import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/model/employee_model.dart';

class PayrollTab extends StatefulWidget {
  final EmployeeModel employee;

  const PayrollTab({
    super.key,
    required this.employee,
  });

  @override
  State<PayrollTab> createState() => _PayrollTabState();
}

class _PayrollTabState extends State<PayrollTab> {
  late TextEditingController salaryController;
  final bankController = TextEditingController();
  final accountController = TextEditingController();

  String paymentFrequency = "Monthly";

  @override
  void initState() {
    super.initState();

    salaryController =
        TextEditingController(text: widget.employee.salary);
  }

  @override
  void dispose() {
    salaryController.dispose();
    bankController.dispose();
    accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: _input("Basic Salary"),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: DropdownButtonFormField<String>(
                  value: paymentFrequency,
                  decoration: _input("Payment Frequency"),
                  items: const [
                    DropdownMenuItem(
                      value: "Monthly",
                      child: Text("Monthly"),
                    ),
                    DropdownMenuItem(
                      value: "Weekly",
                      child: Text("Weekly"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      paymentFrequency = value!;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          TextField(
            controller: bankController,
            decoration: _input("Bank Name"),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: accountController,
            decoration: _input("Account Number"),
          ),
        ],
      ),
    );
  }

  InputDecoration _input(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}