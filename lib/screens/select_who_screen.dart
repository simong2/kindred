import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_entry.dart';
import 'package:kindred/screens/org/org_entry.dart';
import 'package:kindred/screens/org/org_register/login.dart';
import 'package:kindred/utils/CustomButton.dart';

const darkGreen = 0xFF667B68;
const mediumGreen = 0xFFA3B899;
const lightGreen = 0xFFDDE6D5;

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
      backgroundColor: const Color(0xFFDDE6D5),
      body: Column(
        children: [
          SizedBox(
            height: height * .35,
            width: double.infinity,
            child: Container(
              child: const Center(
                child: Text(
                  'kindred',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.w500,
                    color: Color(darkGreen), // Text color
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3), // Shadow position
                        blurRadius: 1.0, // Blur effect
                        color: Color(mediumGreen), // Shadow color
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                /*decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),  
                ),*/
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: CustomButton(
                          label: "Donor",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonorEntry()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFFA3B899), // Button background color
                            foregroundColor: Color(0xFF667B68),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: const BorderSide(
                                  color: const Color(0xFF667B68), width: 2),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrgEntry()),
                            );
                          },
                          child: const Text('Organization'),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/img/mushroom.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
