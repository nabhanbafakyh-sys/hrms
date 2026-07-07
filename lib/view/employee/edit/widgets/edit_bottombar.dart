import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/view_model/employee_vm.dart';

class EditBottomBar extends StatelessWidget {
  final int employeeId;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController dobController;

  final TextEditingController salaryController;
  final TextEditingController joiningController;

  final int? departmentId;
  final int? designationId;
  final int? reportingManagerId;

  final String status;

  const EditBottomBar({
    super.key,
    required this.employeeId,

    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.dobController,

    required this.salaryController,
    required this.joiningController,

    required this.departmentId,
    required this.designationId,
    required this.reportingManagerId,

    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EmployeeViewModel>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xffE5E5E5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          const SizedBox(width: 16),

          ElevatedButton(
            onPressed: vm.isLoading
                ? null
                : () async {
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
                    debugPrint("UPDATE DATA: $data");
                    debugPrint("Department ID : $departmentId");
                    debugPrint("Designation ID : $designationId");
                    debugPrint("Status : $status");
                    debugPrint(data.toString());
                    final success = await vm.updateEmployee(employeeId, data);

                    if (!context.mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Employee Updated Successfully"),
                        ),
                      );

                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(vm.errorMessage ?? "Update Failed"),
                        ),
                      );
                    }
                  },
            child: vm.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Save Profile"),
          ),
        ],
      ),
    );
  }
}
