
import 'package:flutter/material.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
        child: Column(
          children: [
            const Text(
              "Choose your role",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Select your role to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 55),

            // Customer
            roleTile(
              index: 0,
              icon: Icons.person,
              title: "Customer",
              subtitle: "Book rooms and enjoy hotel services",
            ),

            const SizedBox(height: 15),

            // Hotel
            roleTile(
              index: 1,
              icon: Icons.hotel,
              title: "Hotel",
              subtitle: "Manage rooms and hotel services",
            ),

            const SizedBox(height: 15),

            // Restaurant
            roleTile(
              index: 2,
              icon: Icons.restaurant,
              title: "Restaurant",
              subtitle: "Manage restaurant and food services",
            ),

            const SizedBox(height: 15),

      

            // Health Club
            roleTile(
              index: 4,
              icon: Icons.fitness_center,
              title: "Health Club",
              subtitle: "Access fitness, wellness and health services",
            ),
          ],
        ),
      ),
    );
  }

  Widget roleTile({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    bool isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isHovered
              ? const Color(0xFF3F4A32)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isHovered ? Colors.white : Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isHovered ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: isHovered ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

