import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class PersonalTab extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController dobController;

  const PersonalTab({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.dobController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: AppColors.primary.withOpacity(.15),
            child: const Icon(
              Icons.person,
              size: 50,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: _field(
                  controller: nameController,
                  label: "Full Name",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _field(
                  controller: phoneController,
                  label: "Phone",
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _field(
                  controller: emailController,
                  label: "Email",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _field(
                  controller: dobController,
                  label: "Date of Birth",
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _field(
            controller: addressController,
            label: "Address",
            maxLines: 3,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _field(
                  label: "Emergency Contact",
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _field(
                  label: "Emergency Phone",
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _field(
            label: "Skills",
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _field({
    TextEditingController? controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}