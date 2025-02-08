import 'package:flutter/material.dart';

class LoginState extends StatefulWidget {
  const LoginState({super.key});

  @override
  State<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginState> {
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
                  'Donor Login',
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
                  color: Colors.blueGrey,
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
                        child: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              labelText: 'Email',
                        )),
                      ),
                      SizedBox(
                        width: width / 2,
                        child: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              labelText: 'Password',
                        )),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Login'),
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
