import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class ContractStep extends StatelessWidget {
  const ContractStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contract Details",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Configure employee contract information.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 25),

          _dropdown("Employment Type"),

          const SizedBox(height: 16),

          _dropdown("Contract Type"),

          const SizedBox(height: 16),

          _dropdown("Contract Status"),

          const SizedBox(height: 16),

          _dateField("Contract Start Date"),

          const SizedBox(height: 16),

          _dateField("Contract End Date"),

          const SizedBox(height: 16),

          _uploadField("Upload Contract"),
        ],
      ),
    );
  }

  Widget _dropdown(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [],
      onChanged: (_) {},
    );
  }

  Widget _dateField(String hint) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.calendar_month_outlined),
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

  Widget _uploadField(String hint) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.upload_file),
        suffixIcon: const Icon(Icons.attach_file),
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