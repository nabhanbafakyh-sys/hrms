import 'package:flutter/material.dart';

class PrimaryInfoCard extends StatelessWidget {
  final String phone;
  final String email;
  final String address;
  final String dob;
  final String joiningDate;
  final String salary;
  final String reportingManager;

  const PrimaryInfoCard({
    super.key,
    required this.phone,
    required this.email,
    required this.address,
    required this.dob,
    required this.joiningDate,
    required this.salary,
    required this.reportingManager,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Primary Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _infoTile(Icons.phone, "Phone", phone),
            const Divider(),

            _infoTile(Icons.email_outlined, "Email", email),
            const Divider(),

            _infoTile(Icons.location_on_outlined, "Address", address),
            const Divider(),

            _infoTile(Icons.cake_outlined, "Date of Birth", dob),
            const Divider(),

            _infoTile(Icons.calendar_month_outlined, "Joining Date", joiningDate),
            const Divider(),

            _infoTile(Icons.currency_rupee, "Salary", salary),
            const Divider(),

            _infoTile(Icons.person_outline, "Reporting Manager", reportingManager),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.withOpacity(.1),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value.isEmpty ? "-" : value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}