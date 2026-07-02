import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: AppColors.scaffold,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppSearchBar(hintText: 'search'),

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
                            const DropdownMenuItem(
                              value: "All Departments",
                              child: Text("All Departments"),
                            ),

                            ...vm.departments.map(
                              (department) => DropdownMenuItem(
                                value: department.name,
                                child: Text(department.name),
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton.icon(
                    onPressed: () {},
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

                    return ListView.builder(
                      itemCount: vm.employees.length,
                      itemBuilder: (context, index) {
                        final employee = vm.employees[index];

                        return EmployeeCard(
                          employeeId: employee.employeeCode ?? "-",
                          name: employee.name,
                          designation: employee.designation.toString(),
                          department: employee.department.toString(),
                          status: employee.status,
                        );
                      },
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
