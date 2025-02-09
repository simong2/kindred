import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kindred/firebase_options.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 40
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                          "User Details"
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      indent: width * 0.05,
                      endIndent: width * 0.05,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 40
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,  
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                          textAlign: TextAlign.left,
                          "Username: ??"
                        ),
                      ],
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 40
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,  
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                          textAlign: TextAlign.left,
                          "Username: ??"
                        ),
                      ],
                    ),
                    
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}