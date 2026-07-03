import 'package:flutter/material.dart';
import 'package:hrms_app/view/employee/widgets/overview-tab.dart';
import 'package:hrms_app/view/employee/widgets/primary_info.dart';
import 'package:hrms_app/view/employee/widgets/stat_card.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/view/employee/widgets/employee_header.dart';
import 'package:hrms_app/view/employee/widgets/skills_card.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';
import 'package:hrms_app/view_model/employee_vm.dart';

class EmployeeDetails extends StatefulWidget {
  final int employeeId;

  const EmployeeDetails({
    super.key,
    required this.employeeId,
  });

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<EmployeeViewModel>().getEmployeeById(widget.employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final departmentVM = context.watch<DepartmentViewModel>();
    final designationVM = context.watch<DesignationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text("Employee Details"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.scaffold,
      ),
      body: Consumer<EmployeeViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(vm.errorMessage!),
            );
          }

          final employee = vm.selectedEmployee;

          if (employee == null) {
            return const Center(
              child: Text("Employee not found"),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                EmployeeHeader(
                  name: employee.name,
                  designation: designationVM.getDesignationTitle(
                    employee.designation,
                  ),
                  department: departmentVM.getDepartmentName(
                    employee.department,
                  ),
                  employeeCode: employee.employeeCode ?? "-",
                  phone: employee.phone,
                  email: employee.email,
                  status: employee.status,
                  reportingManager:
                      employee.reportingManager?.toString() ?? "No Manager",
                ),

                const SizedBox(height: 20),

                const OverviewTabs(),

                const SizedBox(height: 20),

                Row(
                  children: const [
                    StatsCard(
                      title: "Attendance",
                      value: "96%",
                      subtitle: "Attendance Rate",
                      icon: Icons.calendar_month_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(width: 12),
                    StatsCard(
                      title: "Leave",
                      value: "14",
                      subtitle: "Days Left",
                      icon: Icons.beach_access_outlined,
                      color: Colors.orange,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: const [
                    StatsCard(
                      title: "OT Summary",
                      value: "12.5h",
                      subtitle: "This Month",
                      icon: Icons.schedule_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 12),
                    StatsCard(
                      title: "Emergency",
                      value: "--",
                      subtitle: "Not Added",
                      icon: Icons.contact_phone_outlined,
                      color: Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                PrimaryInfoCard(
                  phone: employee.phone,
                  email: employee.email,
                  address: employee.address,
                  dob: employee.dateOfBirth.toString(),
                  joiningDate: employee.joiningDate.toString(),
                  salary: employee.salary.toString(),
                  reportingManager:
                      employee.reportingManager?.toString() ?? "No Manager",
                ),

                const SizedBox(height: 20),

                const SkillsCard(),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}