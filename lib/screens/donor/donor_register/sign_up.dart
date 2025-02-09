import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';
import 'package:kindred/utils/CustomButton.dart';

const darkGreen = 0xFF667B68;
const mediumGreen = 0xFFA3B899;
const lightGreen = 0xFFDDE6D5; //

class SignUpDonor extends StatefulWidget {
  const SignUpDonor({super.key});

  @override
  State<SignUpDonor> createState() => _SignUpDonorState();
}

class _SignUpDonorState extends State<SignUpDonor> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height / 1.5,
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width / 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 1.3,
                        child: TextFormField(
                          controller: _usernameController,
                          cursorColor: Color(darkGreen),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            fillColor: Colors.white,
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Color(
                                    darkGreen)), // Changed label text color
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Color(darkGreen)), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(darkGreen),
                                  width: 2.0), // Focused border color and width
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Username is required' : null,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: width / 1.3,
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Color(darkGreen),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(darkGreen)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Color(darkGreen)), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(darkGreen),
                                  width: 2.0), // Focused border color and width
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: width / 1.3,
                        child: TextFormField(
                          controller: _passwordController,
                          cursorColor: Color(darkGreen),
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye),
                            ),
                            fillColor: Colors.white,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Color(darkGreen)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Color(darkGreen)), // Default border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(darkGreen),
                                  width: 2.0), // Focused border color and width
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                          width: width / 2,
                          height: height * .06,
                          child: CustomButton(
                            label: 'Sign Up',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  print('account created');
                                  FirebaseServices().createDonor(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text,
                                  );
                                  Navigator.pop(context);
                                } catch (e) {
                                  print('account account creation failed');
                                  print(e.toString());
                                }
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
