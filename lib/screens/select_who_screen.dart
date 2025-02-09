import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              Text(
                'Welcome to Kindred App',
                style: GoogleFonts.roboto(
                  fontSize: 28, // Slightly larger for better visibility
                  fontWeight: FontWeight.w600, // Semi-bold for a refined look
                  color: Colors.white, // Keeps contrast with the background
                  letterSpacing:
                      1.2, // Adds slight spacing for better readability
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1), // Light shadow for depth
                      blurRadius: 3,
                      color:
                          Colors.black.withOpacity(0.3), // Subtle shadow effect
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Expanded image container with dynamic height adjustment
              Container(
                width: width, // Full screen width
                height:
                    width * (500 / 500), // Adjust height based on aspect ratio
                child: Image.asset(
                  'lib/img/kindred-bg-logo.png', // Path to your image
                  fit: BoxFit.fitWidth, // Ensure the image fits the width
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
                            builder: (context) => const LoginState(),
                          ),
                        );
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
