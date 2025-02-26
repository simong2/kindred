import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/main_donor_screen.dart';
import 'package:kindred/services/firebase_services.dart';
import 'package:kindred/utils/CustomButton.dart';

const darkGreen = 0xFF667B68;
const mediumGreen = 0xFFA3B899;
const lightGreen = 0xFFDDE6D5; //

class LoginDonor extends StatefulWidget {
  const LoginDonor({super.key});

  @override
  State<LoginDonor> createState() => _LoginDonorState();
}

class _LoginDonorState extends State<LoginDonor> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 1.5,
      ),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
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
              SizedBox(
                width: width / 1.3,
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Color(darkGreen),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email,
                        color: Color(darkGreen)), // Changed icon color
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen)), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(darkGreen),
                          width: 2.0), // Focused border color and width
                    ),
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
                    labelStyle: TextStyle(
                        color: Color(darkGreen)), // Changed label text color
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
                  label: "Login",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('logging in');
                      try {
                        FirebaseServices().logDonorIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        print('log in failed');
                        print(e.toString());
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
