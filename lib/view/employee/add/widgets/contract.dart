import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class ContractStep extends StatefulWidget {
  const ContractStep({super.key});

  @override
  State<ContractStep> createState() => _ContractStepState();
}

class _ContractStepState extends State<ContractStep> {
  String? employmentType;
  String? contractType;
  String? contractStatus;

  final TextEditingController startDateController =
      TextEditingController();
  final TextEditingController endDateController =
      TextEditingController();

  Future<void> pickDate(TextEditingController controller) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (date != null) {
      controller.text = date.toIso8601String().split("T").first;
    }
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

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
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 25),

          DropdownButtonFormField<String>(
            value: employmentType,
            decoration: decoration("Employment Type"),
            items: const [
              DropdownMenuItem(
                value: "Full Time",
                child: Text("Full Time"),
              ),
              DropdownMenuItem(
                value: "Part Time",
                child: Text("Part Time"),
              ),
              DropdownMenuItem(
                value: "Intern",
                child: Text("Intern"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                employmentType = value;
              });
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: contractType,
            decoration: decoration("Contract Type"),
            items: const [
              DropdownMenuItem(
                value: "Permanent",
                child: Text("Permanent"),
              ),
              DropdownMenuItem(
                value: "Temporary",
                child: Text("Temporary"),
              ),
              DropdownMenuItem(
                value: "Freelance",
                child: Text("Freelance"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                contractType = value;
              });
            },
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: contractStatus,
            decoration: decoration("Contract Status"),
            items: const [
              DropdownMenuItem(
                value: "Active",
                child: Text("Active"),
              ),
              DropdownMenuItem(
                value: "Expired",
                child: Text("Expired"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                contractStatus = value;
              });
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: startDateController,
            readOnly: true,
            onTap: () => pickDate(startDateController),
            decoration: decoration("Contract Start Date").copyWith(
              suffixIcon: const Icon(Icons.calendar_month),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: endDateController,
            readOnly: true,
            onTap: () => pickDate(endDateController),
            decoration: decoration("Contract End Date").copyWith(
              suffixIcon: const Icon(Icons.calendar_month),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            readOnly: true,
            decoration: decoration("Upload Contract").copyWith(
              prefixIcon: const Icon(Icons.upload_file),
              suffixIcon: IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "File upload will be added later",
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}