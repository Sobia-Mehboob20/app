
import 'package:app/customer_dashboard.dart';
import 'package:app/receptionist.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'manager_dashboard.dart';
import 'sigin.dart';

class Login extends StatefulWidget {
  final String role;

  const Login({
    super.key,
    required this.role,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (!userData.exists) {
        throw Exception("User data not found.");
      }

      String role = userData['role'];

      print("Login Successful");
      print("Role: $role");

      if (!mounted) return;

      if (role.toLowerCase() == widget.role.toLowerCase()) {
  if (widget.role == "Manager") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ManagerDashboard(),
      )
      
    );}
  
 else if (widget.role == "Receptionist")
    {
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ReceptionistDashboard(),
      ),
      );
      
    } 
    else if (widget.role == "Customer")
    {
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerDashboard(),
      ),
          
      );
      
    }}

 else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("You are not authorized for this role."),
    ),
  );
} 
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "Login failed.";

      if (e.code == 'user-not-found') {
        message = "No account found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else if (e.code == 'invalid-credential') {
        message = "Invalid email or password.No user exist with this email and pasword";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Login as ${widget.role}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // NAME
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Enter your name",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name";
                      }

                      if (value.trim().length < 3) {
                        return "Name must be at least 3 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // EMAIL
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your email";
                      }

                      final emailPattern =
                          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                      if (!emailPattern.hasMatch(value.trim())) {
                        return "Please enter a valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // PASSWORD
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,

                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Icons.lock_outline),

                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }

                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  // LOGIN BUTTON
                  SizedBox(
                    height: 52,

                    child: ElevatedButton(
                      onPressed: _isLoading ? null : loginUser,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F4A32),
                        foregroundColor: const Color(0xFFF5F0E8),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // SIGN UP
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

