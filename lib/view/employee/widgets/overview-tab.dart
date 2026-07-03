import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class OverviewTabs extends StatelessWidget {
  const OverviewTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tab(
            title: "OVERVIEW",
            selected: true,
          ),
          _tab(
            title: "JOB DETAILS",
            selected: false,
          ),
          _tab(
            title: "PAYROLL",
            selected: false,
          ),
        ],
      ),
    );
  }

  Widget _tab({
    required String title,
    required bool selected,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: selected
              ? const Border(
                  bottom: BorderSide(
                    color: AppColors.primary,
                    width: 3,
                  ),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected
                ? AppColors.primary
                : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}