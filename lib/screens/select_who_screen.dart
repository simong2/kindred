import 'package:flutter/material.dart';
import 'package:kindred/screens/login.dart';
import 'package:kindred/screens/orglogin.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: height * .35,
            width: double.infinity,
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Who am I',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 2,
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
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OrgLoginState()));
                          },
                          child: const Text('Organization'),
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
