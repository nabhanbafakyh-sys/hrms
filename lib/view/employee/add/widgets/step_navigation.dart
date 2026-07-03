import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class StepNavigation extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepNavigation({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                child: const Text("Back"),
              ),
            ),

          if (currentStep > 0) const SizedBox(width: 12),

          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                currentStep == 5 ? "Finish" : "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }
}