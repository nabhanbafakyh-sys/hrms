import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class DocumentStep extends StatelessWidget {
  final TextEditingController skillsController;
  final TextEditingController passportController;
  final TextEditingController aadhaarController;
  final TextEditingController panController;

  const DocumentStep({
    super.key,
    required this.skillsController,
    required this.passportController,
    required this.aadhaarController,
    required this.panController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: skillsController,
            decoration: _decoration("Skills (Comma Separated)"),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: passportController,
                  decoration: _decoration("Passport Number"),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: aadhaarController,
                  decoration: _decoration("Aadhaar Number"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          TextField(
            controller: panController,
            decoration: _decoration("PAN Number"),
          ),

          const SizedBox(height: 30),

          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 35),
                  SizedBox(height: 10),
                  Text("Upload Documents"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}