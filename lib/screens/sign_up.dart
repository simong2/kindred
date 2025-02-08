import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  color: Colors.blue,
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
                          onPressed: () {},
                          child: const Text('Donor'),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          onPressed: () {},
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
