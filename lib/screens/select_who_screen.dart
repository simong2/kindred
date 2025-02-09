import 'package:flutter/material.dart';
import 'package:kindred/screens/login.dart';

class SelectWhoScreen extends StatefulWidget {
  const SelectWhoScreen({super.key});

  @override
  State<SelectWhoScreen> createState() => _SelectWhoScreenState();
}

class _SelectWhoScreenState extends State<SelectWhoScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF80BFFF), // Light Carolina Blue
              Color(0xFF0066CC), // Deeper Blue
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Kinder App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 3,
                    height: height * .06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginState()));
                      },
                      child: const Text('Donor'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: width / 3,
                    height: height * .06,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Organization'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
