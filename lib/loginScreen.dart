
import 'package:app/amenities.dart';
import 'package:app/login.dart';
import 'package:app/sigin.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),

          child: Column(
            children: [

              const SizedBox(height: 35),

              // Logo / App Name
              const Text(
                "LUXORA",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 35),

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

              const SizedBox(height: 10),

              const Text(
                "Experience comfort, luxury\nand excellence.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 28),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(24),

                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaHDSYYDJWkxicmMcE0gqpNvgSS91sNvsjiqleC3tYnfYfMb33CDkoaBcu&s=10",
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,

                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      height: 300,
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
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

              const Spacer(),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xFF3F4A32) ,
                        foregroundColor:  Color(0xFFF5F0E8),

                    elevation: 0,

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
                      MaterialPageRoute(
                        builder: (context) => const Signin(),
                      ),
                    );
                  },

                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black26,
                      width: 1.2,
                    ),

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

              const SizedBox(height: 30),

               


              // Bottom text
              const Text(
                "Your comfort, our priority.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
