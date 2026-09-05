import 'dart:async';
import 'package:app/loginScreen.dart';
import 'package:app/role.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      // Next screen par navigation yahan karna hai
      Navigator.push(context,MaterialPageRoute(builder:(context)=> const Role()),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
   (backgroundColor:const Color.fromARGB(255, 134, 104, 93),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
     Center(
            child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiyFqz0Qm3PiNhFCtbwc9pUkF7Wwq994x7uBwhezyNJQ&s=10'
            ,width:150,
            height:150)    ), 

            SizedBox(height: 30,),

     Text(
            "Hotel Booking",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
  
    ],

        
      ),


       
    );
  }
}
