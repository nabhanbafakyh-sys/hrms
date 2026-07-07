import 'package:flutter/material.dart';
import 'package:hrms_app/view/employee/edit/widgets/edit_bottombar.dart';
import 'package:hrms_app/view/employee/widgets/job_tab.dart';
import 'package:hrms_app/view/employee/widgets/payroll_tab.dart';
import 'package:hrms_app/view/employee/widgets/personal_tab.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/view_model/employee_vm.dart';

class EditEmployeeScreen extends StatefulWidget {
  final int employeeId;

  const EditEmployeeScreen({super.key, required this.employeeId});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final salaryController = TextEditingController();
  final joiningController = TextEditingController();

  int? departmentId;
  int? designationId;
  int? reportingManagerId;
  String status = "Active";
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);

    Future.microtask(() {
      context.read<EmployeeViewModel>().getEmployeeById(widget.employeeId);
    });
  }

  @override
  void dispose() {
    tabController.dispose();

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dobController.dispose();

    salaryController.dispose();
    joiningController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Employee",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: "Personal Info"),
            Tab(text: "Job Details"),
            Tab(text: "Payroll & Bank"),
          ],
        ),
      ),
      body: Consumer<EmployeeViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.selectedEmployee == null) {
            return const Center(child: Text("Employee not found"));
          }

          final employee = vm.selectedEmployee!;

          if (!loaded) {
            loaded = true;

            nameController.text = employee.name;
            emailController.text = employee.email;
            phoneController.text = employee.phone;
            addressController.text = employee.address ?? "";
            dobController.text = employee.dateOfBirth ?? "";

            salaryController.text = employee.salary;
            joiningController.text = employee.joiningDate;

            departmentId = employee.department;
            designationId = employee.designation;
            reportingManagerId = employee.reportingManager;
            status = employee.status;
          }

          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    PersonalTab(
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      addressController: addressController,
                      dobController: dobController,
                    ),

                    JobTab(
                      salaryController: salaryController,
                      joiningController: joiningController,

                      departmentId: departmentId,
                      designationId: designationId,
                      reportingManagerId: reportingManagerId,
                      status: status,

                      onDepartmentChanged: (value) {
                        setState(() {
                          departmentId = value;
                        });
                      },

                      onDesignationChanged: (value) {
                        setState(() {
                          designationId = value;
                        });
                      },

                      onReportingManagerChanged: (value) {
                        setState(() {
                          reportingManagerId = value;
                        });
                      },

                      onStatusChanged: (value) {
                        setState(() {
                          status = value ?? "Active";
                        });
                      },
                    ),
                    PayrollTab(employee: employee),
                  ],
                ),
              ),

              EditBottomBar(
                employeeId: employee.id,

                nameController: nameController,
                emailController: emailController,
                phoneController: phoneController,
                addressController: addressController,
                dobController: dobController,

                salaryController: salaryController,
                joiningController: joiningController,

                departmentId: departmentId,
                designationId: designationId,
                reportingManagerId: reportingManagerId,
                status: status,
              ),
            ],
          );
        },
      ),
    );
  }
}
