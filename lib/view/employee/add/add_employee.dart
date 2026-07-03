import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hrms_app/view/employee/add/widgets/profile_info.dart';
import 'package:hrms_app/view/employee/add/widgets/job_details.dart';
import 'package:hrms_app/view/employee/add/widgets/contract.dart';
import 'package:hrms_app/view/employee/add/widgets/employee_steeper.dart';
import 'package:hrms_app/view/employee/add/widgets/step_navigation.dart';

import 'package:hrms_app/view_model/employee_vm.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  int currentStep = 0;

  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final salaryController = TextEditingController();
  final joiningController = TextEditingController();

  /// Dropdown values
  int? departmentId;
  int? designationId;
  int? reportingManagerId;

  String status = "Active";

  late final List<Widget> steps;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DepartmentViewModel>().getDepartments();
      context.read<DesignationViewModel>().getDesignations();
    });

    steps = [
      PersonalInfoStep(
        nameController: nameController,
        emailController: emailController,
        phoneController: phoneController,
        addressController: addressController,
        dobController: dobController,
      ),

      JobDetailsStep(
        salaryController: salaryController,
        joiningController: joiningController,

        onDepartmentChanged: (value) {
          departmentId = value;
        },

        onDesignationChanged: (value) {
          designationId = value;
        },

        onReportingManagerChanged: (value) {
          reportingManagerId = value;
        },

        onStatusChanged: (value) {
          status = value ?? "Active";
        },
      ),

      const ContractStep(),
    ];
  }

  @override
  void dispose() {
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
        title: const Text("Add Employee"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            EmployeeStepper(currentStep: currentStep),

            Expanded(
              child: steps[currentStep],
            ),

            StepNavigation(
              currentStep: currentStep,

              onBack: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep--;
                  });
                } else {
                  Navigator.pop(context);
                }
              },

              onNext: () async {
                if (currentStep < steps.length - 1) {
                  setState(() {
                    currentStep++;
                  });
                  return;
                }

                final data = {
                  "name": nameController.text.trim(),
                  "email": emailController.text.trim(),
                  "phone": phoneController.text.trim(),
                  "address": addressController.text.trim(),
                  "date_of_birth": dobController.text,
                  "salary": salaryController.text.trim(),
                  "joining_date": joiningController.text,
                  "status": status,
                  "department": departmentId,
                  "designation": designationId,
                  "reporting_manager": reportingManagerId,
                };

                final success = await context
                    .read<EmployeeViewModel>()
                    .addEmployee(data);

                if (!mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Employee Added Successfully"),
                    ),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        context.read<EmployeeViewModel>().errorMessage ??
                            "Failed to add employee",
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}