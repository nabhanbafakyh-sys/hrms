import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';
import 'package:hrms_app/view_model/employee_form_vm.dart';

class PersonalInfoStep extends StatelessWidget {
  final EmployeeFormViewModel formVM;

  final String? nameError;
  final String? emailError;
  final String? phoneError;

  const PersonalInfoStep({
    super.key,
    required this.formVM,
    this.nameError,
    this.emailError,
    this.phoneError,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Complete the employee's personal details.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor:
                      AppColors.primary.withOpacity(.12),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _field(
            context,
            controller: formVM.nameController,
            hint: "Full Name",
            icon: Icons.person_outline,
            validator: formVM.validateName,
            errorText: nameError,
          ),

          const SizedBox(height: 16),

          _field(
            context,
            controller: formVM.emailController,
            hint: "Email",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: formVM.validateEmail,
            errorText: emailError,
          ),

          const SizedBox(height: 16),

          _field(
            context,
            controller: formVM.phoneController,
            hint: "Phone Number",
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: formVM.validatePhone,
            errorText: phoneError,
          ),

          const SizedBox(height: 16),

          _field(
            context,
            controller: formVM.dobController,
            hint: "Date of Birth",
            icon: Icons.calendar_today_outlined,
            readOnly: true,
          ),

          const SizedBox(height: 16),

          _field(
            context,
            controller: formVM.addressController,
            hint: "Address",
            icon: Icons.location_on_outlined,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    String? errorText,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onTap: readOnly
          ? () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );

              if (date != null) {
                controller.text =
                    date.toIso8601String().split("T").first;
              }
            }
          : null,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        prefixIcon: Icon(icon),
        suffixIcon: readOnly
            ? const Icon(Icons.calendar_today_outlined)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}