import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/view/employee/widgets/employee_card.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';
import 'package:hrms_app/view_model/employee_vm.dart';
import 'package:hrms_app/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<EmployeeViewModel>().getEmployees();
      context.read<DepartmentViewModel>().getDepartments();
      context.read<DesignationViewModel>().getDesignations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final departmentVM = context.watch<DepartmentViewModel>();
    final designationVM = context.watch<DesignationViewModel>();
    return Scaffold(
      backgroundColor: AppColors.scaffold,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppSearchBar(
                hintText: "Search employees...",
                onChanged: (value) {
                  context.read<EmployeeViewModel>().searchEmployee(value);
                },
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Consumer<DepartmentViewModel>(
                      builder: (context, vm, child) {
                        return DropdownButtonFormField<String>(
                          value: "All Departments",
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: "All Departments",
                              child: Text("All Departments"),
                            ),

                            ...vm.departments.map(
                              (department) => DropdownMenuItem<String>(
                                value: department.id.toString(),
                                child: Text(department.name),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              context
                                  .read<EmployeeViewModel>()
                                  .filterByDepartment(value);
                            }
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton.icon(
                    onPressed: () async {
                      await context.pushNamed("add-employee");

                      if (!context.mounted) return;

                      context.read<EmployeeViewModel>().getEmployees();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Consumer<EmployeeViewModel>(
                  builder: (context, vm, child) {
                    if (vm.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (vm.errorMessage != null) {
                      return Center(child: Text(vm.errorMessage!));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "Total Employees: ${vm.filteredEmployees.length}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: vm.filteredEmployees.length,
                            itemBuilder: (context, index) {
                              final employee = vm.filteredEmployees[index];
                              debugPrint(
                                "Employee: ${employee.name}, id: ${employee.id}, code: ${employee.employeeCode}",
                              );
                              return EmployeeCard(
                                id: employee.id,
                                employeeId: employee.employeeCode ?? "-",
                                name: employee.name,
                                designation: designationVM.getDesignationTitle(
                                  employee.designation,
                                ),
                                department: departmentVM.getDepartmentName(
                                  employee.department,
                                ),
                                status: employee.status,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
