import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';
import 'package:provider/provider.dart';

class JobDetailsStep extends StatefulWidget {
  final TextEditingController salaryController;
  final TextEditingController joiningController;

  final ValueChanged<int?> onDepartmentChanged;
  final ValueChanged<int?> onDesignationChanged;
  final ValueChanged<int?> onReportingManagerChanged;
  final ValueChanged<String?> onStatusChanged;

  const JobDetailsStep({
    super.key,
    required this.salaryController,
    required this.joiningController,
    required this.onDepartmentChanged,
    required this.onDesignationChanged,
    required this.onReportingManagerChanged,
    required this.onStatusChanged,
  });

  @override
  State<JobDetailsStep> createState() => _JobDetailsStepState();
}

class _JobDetailsStepState extends State<JobDetailsStep> {
  int? selectedDepartment;
  int? selectedDesignation;
  int? selectedManager;
  String? selectedStatus = "Active";

  @override
  Widget build(BuildContext context) {
    final departmentVM = context.watch<DepartmentViewModel>();
    final designationVM = context.watch<DesignationViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Job Details",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Configure the employee's job information.",
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          DropdownButtonFormField<int>(
            value: selectedDepartment,
            decoration: _decoration("Department"),
            items: departmentVM.departments.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedDepartment = value;
              });

              widget.onDepartmentChanged(value);
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: selectedDesignation,
            decoration: _decoration("Designation"),
            items: designationVM.designations.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedDesignation = value;
              });

              widget.onDesignationChanged(value);
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: widget.joiningController,
            readOnly: true,
            decoration: _decoration(
              "Joining Date",
              icon: Icons.calendar_month_outlined,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: widget.salaryController,
            keyboardType: TextInputType.number,
            decoration: _decoration(
              "Salary",
              icon: Icons.currency_rupee,
            ),
          ),

          const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
            value: selectedStatus,
            decoration: _decoration("Status"),
            items: const [
              DropdownMenuItem(
                value: "Active",
                child: Text("Active"),
              ),
              DropdownMenuItem(
                value: "Inactive",
                child: Text("Inactive"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });

              widget.onStatusChanged(value);
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<int>(
            value: selectedManager,
            decoration: _decoration("Reporting Manager"),
            items: const [
              DropdownMenuItem(
                value: 1,
                child: Text("No Manager"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedManager = value;
              });

              widget.onReportingManagerChanged(value);
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(
    String label, {
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}