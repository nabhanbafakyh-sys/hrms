import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class EmployeeStepper extends StatelessWidget {
  final int currentStep;

  const EmployeeStepper({
    super.key,
    required this.currentStep,
  });

  final List<String> titles = const [
    "Personal",
    "Job",
    "Contract",
    "Payroll",
    "Work",
    "Documents",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      color: AppColors.white,
      child: Row(
        children: List.generate(titles.length, (index) {
          final bool completed = index < currentStep;
          final bool active = index == currentStep;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: completed
                              ? Colors.green
                              : active
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                        ),
                        child: Icon(
                          completed
                              ? Icons.check
                              : Icons.circle,
                          size: completed ? 18 : 12,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: active
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: active
                              ? AppColors.primary
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                if (index != titles.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 22),
                      color: completed
                          ? Colors.green
                          : Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}