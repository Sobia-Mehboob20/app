import 'package:app/login.dart';
import 'package:app/role.dart';
import 'package:app/sigin.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  final String role;

  const Loginscreen({super.key,
    required this.role,});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: const Color(0xFFF5F0E8),

  appBar: AppBar(
    backgroundColor: const Color(0xFFF5F0E8),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),

            child: Column(
              children: [
                

                // Logo / App Name
                const Text(
                  "AURELIA GRAND",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 5),

                // Main Heading
                const Text(
                  "WELCOME",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Experience comfort, luxury\nand excellence.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height:10),

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),

                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaHDSYYDJWkxicmMcE0gqpNvgSS91sNvsjiqleC3tYnfYfMb33CDkoaBcu&s=10",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,

                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Container(
                        height: 300,
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: Colors.black12,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //const Spacer(),
                const SizedBox(height:20),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login(role:widget.role)),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3F4A32),
                      foregroundColor: Color(0xFFF5F0E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin(role:widget.role)),
                      );
                    },

                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black26, width: 1.2),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Create a new account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Bottom text
                const Text(
                  "Your comfort, our priority.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 156, 158, 153),
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
