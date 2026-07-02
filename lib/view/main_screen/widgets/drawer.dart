import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<_DrawerItem> items = [
      _DrawerItem("Employees", Icons.people_outline),
      _DrawerItem("Attendance", Icons.access_time_outlined),
      _DrawerItem("Leave", Icons.event_note_outlined),
      _DrawerItem("Departments", Icons.apartment_outlined),
      _DrawerItem("Payroll", Icons.account_balance_wallet_outlined),
      _DrawerItem("Reports", Icons.bar_chart_outlined),
      _DrawerItem("Settings", Icons.settings_outlined),
    ];

    return Drawer(
      backgroundColor: const Color(0xff102634),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Color(0xff1A2E3B)),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xff10B981),
                    child: Icon(Icons.person, color: Colors.white, size: 35),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "HRMS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Employee Management",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final selected = selectedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: selected
                          ? const Color(0xff10B981)
                          : Colors.transparent,
                      leading: Icon(items[index].icon, color: Colors.white),
                      title: Text(
                        items[index].title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () => onItemSelected(index),
                    ),
                  );
                },
              ),
            ),

            const Divider(color: Colors.white24),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // We'll add logout later
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  final String title;
  final IconData icon;

  _DrawerItem(this.title, this.icon);
}
