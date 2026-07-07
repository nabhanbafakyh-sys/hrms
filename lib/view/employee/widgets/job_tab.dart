import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';
import 'package:provider/provider.dart';

class JobTab extends StatefulWidget {
  final TextEditingController salaryController;
  final TextEditingController joiningController;

  final int? departmentId;
  final int? designationId;
  final int? reportingManagerId;
  final String status;

  final ValueChanged<int?> onDepartmentChanged;
  final ValueChanged<int?> onDesignationChanged;
  final ValueChanged<int?> onReportingManagerChanged;
  final ValueChanged<String?> onStatusChanged;

  const JobTab({
    super.key,
    required this.salaryController,
    required this.joiningController,
    required this.departmentId,
    required this.designationId,
    required this.reportingManagerId,
    required this.status,
    required this.onDepartmentChanged,
    required this.onDesignationChanged,
    required this.onReportingManagerChanged,
    required this.onStatusChanged,
  });

  @override
  State<JobTab> createState() => _JobTabState();
}

class _JobTabState extends State<JobTab> {
  late int? department;
  late int? designation;
  late int? reportingManager;
  late String status;

  @override
  void initState() {
    super.initState();

    department = widget.departmentId;
    designation = widget.designationId;
    reportingManager = widget.reportingManagerId;
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    final departmentVM = context.watch<DepartmentViewModel>();
    final designationVM = context.watch<DesignationViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: designation,
                  decoration: _decoration("Designation"),
                  items: designationVM.designations.map((e) {
                    return DropdownMenuItem(value: e.id, child: Text(e.title));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      designation = value;
                    });

                    widget.onDesignationChanged(value);
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: DropdownButtonFormField<int>(
                  value: department,
                  decoration: _decoration("Department"),
                  items: departmentVM.departments.map((e) {
                    return DropdownMenuItem(value: e.id, child: Text(e.name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      department = value;
                    });

                    widget.onDepartmentChanged(value);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: status,
                  decoration: _decoration("Status"),
                  items: const [
                    DropdownMenuItem(value: "Active", child: Text("Active")),
                    DropdownMenuItem(
                      value: "Inactive",
                      child: Text("Inactive"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      status = value;
                    });

                    widget.onStatusChanged(value);
                  },
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: widget.joiningController,
                  decoration: _decoration("Joining Date"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.salaryController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration("Salary"),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: reportingManager?.toString() ?? "",
                  ),
                  onChanged: (value) {
                    widget.onReportingManagerChanged(int.tryParse(value));
                  },
                  decoration: _decoration("Reporting Manager"),
                ),
              ),
            ],
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
