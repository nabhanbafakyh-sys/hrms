import 'package:flutter/material.dart';
import 'package:hrms_app/core/theme/app_color.dart';

class WorkAreaStep extends StatelessWidget {
  final TextEditingController geoFenceController;

  final String workArea;
  final String shift;
  final bool attendanceRequired;

  final ValueChanged<String?> onWorkAreaChanged;
  final ValueChanged<String?> onShiftChanged;
  final ValueChanged<bool?> onAttendanceChanged;

  const WorkAreaStep({
    super.key,
    required this.geoFenceController,
    required this.workArea,
    required this.shift,
    required this.attendanceRequired,
    required this.onWorkAreaChanged,
    required this.onShiftChanged,
    required this.onAttendanceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: workArea,
                  isExpanded: true,
                  decoration: _decoration("Assign Work Area"),
                  items: const [
                    DropdownMenuItem(
                      value: "Office",
                      child: Text("Office"),
                    ),
                    DropdownMenuItem(
                      value: "Factory",
                      child: Text("Factory"),
                    ),
                    DropdownMenuItem(
                      value: "Remote",
                      child: Text("Remote"),
                    ),
                  ],
                  onChanged: onWorkAreaChanged,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: TextField(
                  controller: geoFenceController,
                  decoration: _decoration("Geo-Fence Location"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            value: shift,
            isExpanded: true,
            decoration: _decoration("Shift Assignment"),
            items: const [
              DropdownMenuItem(
                value: "Morning",
                child: Text("Morning"),
              ),
              DropdownMenuItem(
                value: "Evening",
                child: Text("Evening"),
              ),
              DropdownMenuItem(
                value: "Night",
                child: Text("Night"),
              ),
            ],
            onChanged: onShiftChanged,
          ),

          const SizedBox(height: 20),

          CheckboxListTile(
            value: attendanceRequired,
            onChanged: onAttendanceChanged,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text("Attendance Required"),
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