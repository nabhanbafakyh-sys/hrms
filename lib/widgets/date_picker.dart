import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class AppDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;

  const AppDatePicker({
    super.key,
    required this.controller,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_month),
        suffixIcon: const Icon(Icons.arrow_drop_down),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}