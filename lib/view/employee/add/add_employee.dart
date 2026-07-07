import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:hrms_app/view/employee/add/widgets/profile_info.dart';
import 'package:hrms_app/view/employee/add/widgets/job_details.dart';
import 'package:hrms_app/view/employee/add/widgets/contract.dart';
import 'package:hrms_app/view/employee/add/widgets/payroll_step.dart';
import 'package:hrms_app/view/employee/add/widgets/work_area.dart';
import 'package:hrms_app/view/employee/add/widgets/document_step.dart';
import 'package:hrms_app/view/employee/add/widgets/employee_steeper.dart';
import 'package:hrms_app/view/employee/add/widgets/step_navigation.dart';

import 'package:hrms_app/view_model/employee_vm.dart';
import 'package:hrms_app/view_model/payroll_vm.dart';
import 'package:hrms_app/view_model/document_vm.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  int currentStep = 0;

  final personalFormKey = GlobalKey<FormState>();
  final jobFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  final salaryController = TextEditingController();
  final joiningController = TextEditingController();

  final allowanceController = TextEditingController();
  final deductionController = TextEditingController();
  final payrollRuleController = TextEditingController();

  final geoFenceController = TextEditingController();

  final skillsController = TextEditingController();
  final passportController = TextEditingController();
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();

  int? departmentId;
  int? designationId;
  int? reportingManagerId;

  String status = "Active";

  String wageType = "Monthly Salary";
  bool overtime = false;

  String workArea = "Office";
  String shift = "Morning";
  bool attendanceRequired = false;

  late final List<Widget> steps;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DepartmentViewModel>().getDepartments();
      context.read<DesignationViewModel>().getDesignations();
    });

    steps = [
      Form(
        key: personalFormKey,
        child: PersonalInfoStep(
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
          addressController: addressController,
          dobController: dobController,
        ),
      ),

      Form(
        key: jobFormKey,
        child: JobDetailsStep(
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
      ),

      const ContractStep(),

      PayrollStep(
        salaryController: salaryController,
        allowanceController: allowanceController,
        deductionController: deductionController,
        payrollRuleController: payrollRuleController,
        wageType: wageType,
        overtime: overtime,
        onWageTypeChanged: (value) {
          setState(() {
            wageType = value!;
          });
        },
        onOvertimeChanged: (value) {
          setState(() {
            overtime = value ?? false;
          });
        },
      ),

      WorkAreaStep(
        geoFenceController: geoFenceController,
        workArea: workArea,
        shift: shift,
        attendanceRequired: attendanceRequired,
        onWorkAreaChanged: (value) {
          setState(() {
            workArea = value!;
          });
        },
        onShiftChanged: (value) {
          setState(() {
            shift = value!;
          });
        },
        onAttendanceChanged: (value) {
          setState(() {
            attendanceRequired = value ?? false;
          });
        },
      ),

      DocumentStep(
        skillsController: skillsController,
        passportController: passportController,
        aadhaarController: aadhaarController,
        panController: panController,
      ),
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

    allowanceController.dispose();
    deductionController.dispose();
    payrollRuleController.dispose();

    geoFenceController.dispose();

    skillsController.dispose();
    passportController.dispose();
    aadhaarController.dispose();
    panController.dispose();

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
                  context.pop();
                }
              },

              onNext: () async {
                if (currentStep == 0 &&
                    !personalFormKey.currentState!.validate()) {
                  return;
                }

                if (currentStep == 1 &&
                    !jobFormKey.currentState!.validate()) {
                  return;
                }

                if (currentStep < steps.length - 1) {
                  setState(() {
                    currentStep++;
                  });
                  return;
                }

                final employeeData = {
                  "name": nameController.text.trim(),
                  "email": emailController.text.trim(),
                  "phone": phoneController.text.trim(),
                  "address": addressController.text.trim(),
                  "date_of_birth": dobController.text,
                  "salary": double.tryParse(
                    salaryController.text.trim(),
                  ),
                  "joining_date": joiningController.text,
                  "status": status,
                  "department": departmentId,
                  "designation": designationId,
                  "reporting_manager": reportingManagerId,
                };

                final employeeVM = context.read<EmployeeViewModel>();

                final employee = await employeeVM.addEmployee(employeeData);

                if (!mounted) return;

                if (employee == null) {
                  return;
                }

                final payrollSuccess = await context
                    .read<PayrollViewModel>()
                    .createPayroll({
                  "employee": employee.id,
                  "month": DateTime.now().month,
                  "year": DateTime.now().year,
                  "basic_salary": salaryController.text.trim(),
                  "allowances": allowanceController.text.isEmpty
                      ? "0"
                      : allowanceController.text,
                  "hra": "0",
                  "pf": "0",
                  "esi": "0",
                  "tds": "0",
                  "loss_of_pay": "0",
                  "bonuses": "0",
                  "incentives": "0",
                  "arrears": "0",
                  "final_settlement": "0",
                });

                if (!payrollSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        context
                                .read<PayrollViewModel>()
                                .errorMessage ??
                            "Payroll creation failed",
                      ),
                    ),
                  );
                  return;
                }

                final documentVM = context.read<DocumentViewModel>();

                Future<void> uploadDocument(
                  String value,
                  String type,
                ) async {
                  if (value.trim().isEmpty) return;

                  await documentVM.uploadDocument({
                    "employee": employee.id,
                    "document_name": value.trim(),
                    "document_type": type,
                  });
                }

                await uploadDocument(
                  passportController.text,
                  "Passport",
                );

                await uploadDocument(
                  aadhaarController.text,
                  "Aadhaar",
                );

                await uploadDocument(
                  panController.text,
                  "PAN",
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Employee Created Successfully",
                    ),
                  ),
                );

                context.pop(true);
              },
            ),
          ],
        ),
      ),
    );
  }
}