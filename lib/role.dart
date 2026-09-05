import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'login.dart';

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
      backgroundColor: const Color(0xFFF7F5F0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  const Icon(
                    Icons.hotel,
                    size: 50,
                    color: Color(0xFF3F4A32),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Choose Your Role",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Select your role to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  roleTile(
                    index: 0,
                    icon: Icons.admin_panel_settings_outlined,
                    title: "Admin",
                    subtitle: "Full access to all modules",
                  ),

                  const SizedBox(height: 15),

                  roleTile(
                    index: 1,
                    icon: Icons.room_service_outlined,
                    title: "Receptionist",
                    subtitle: "Handle bookings and operations",
                  ),

                  const SizedBox(height: 15),

                  roleTile(
                    index: 2,
                    icon: Icons.restaurant_outlined,
                    title: "Owner",
                    subtitle: "Manage your restaurant",
                  ),

                  const SizedBox(height: 15),

                  roleTile(
                    index: 3,
                    icon: Icons.person_outline,
                    title: "Customer",
                    subtitle: "View, book and order services",
                  ),
                ],
              ),
            ),
          ),
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
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? const Color(0xFF3F4A32)
                : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          onTap: ()
          {
            Navigator.push(context,MaterialPageRoute(builder:(context)=>Loginscreen(role:title,),
            
            ),
              );
                
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),

          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isHovered
                  ? Colors.white.withOpacity(0.15)
                  : const Color(0xFFF0F1EB),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 27,
              color: isHovered
                  ? Colors.white
                  : const Color(0xFF3F4A32),
            ),
          ),

          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isHovered
                  ? Colors.white
                  : const Color(0xFF222222),
            ),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: isHovered
                    ? Colors.white70
                    : Colors.grey.shade600,
              ),
            ),
          )
          ),
        ),
      );
    //);
  }
}