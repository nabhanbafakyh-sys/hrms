import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class PayrollStep extends StatelessWidget {
  final TextEditingController salaryController;
  final TextEditingController allowanceController;
  final TextEditingController deductionController;
  final TextEditingController payrollRuleController;

  final String wageType;
  final ValueChanged<String?> onWageTypeChanged;

  final bool overtime;
  final ValueChanged<bool?> onOvertimeChanged;

  const PayrollStep({
    super.key,
    required this.salaryController,
    required this.allowanceController,
    required this.deductionController,
    required this.payrollRuleController,
    required this.wageType,
    required this.onWageTypeChanged,
    required this.overtime,
    required this.onOvertimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: wageType,
                  isExpanded: true,
                  decoration: _decoration("Wage Type"),
                  items: const [
                    DropdownMenuItem(
                      value: "Monthly Salary",
                      child: Text("Monthly Salary"),
                    ),
                    DropdownMenuItem(
                      value: "Hourly",
                      child: Text("Hourly"),
                    ),
                    DropdownMenuItem(
                      value: "Daily",
                      child: Text("Daily"),
                    ),
                  ],
                  onChanged: onWageTypeChanged,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration("Basic Salary / Rate"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: allowanceController,
                  decoration: _decoration("Allowances"),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: deductionController,
                  decoration: _decoration("Deductions"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          TextField(
            controller: payrollRuleController,
            decoration: _decoration("Payroll Calculation Rules"),
          ),

          const SizedBox(height: 20),

          CheckboxListTile(
            value: overtime,
            onChanged: onOvertimeChanged,
            contentPadding: EdgeInsets.zero,
            title: const Text("Eligible for Overtime"),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label) {
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