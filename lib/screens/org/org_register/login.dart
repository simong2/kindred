import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

const darkGreen = 0xFF667B68;
const mediumGreen = 0xFFA3B899;
const lightGreen = 0xFFDDE6D5; // Define the darkGreen color constant

class LoginOrg extends StatefulWidget {
  const LoginOrg({super.key});

  @override
  State<LoginOrg> createState() => _LoginOrgState();
}

class _LoginOrgState extends State<LoginOrg> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    validator: (value) => value!.isEmpty || value == null
                        ? 'Email is required'
                        : null,
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
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(darkGreen)),
                      // Lock icon color
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(darkGreen), // Eye icon color
                        ),
                      ),
                      labelText: 'Password',
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
                        value!.isEmpty ? 'Password is required' : null,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: width / 2,
                  height: height * .06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(mediumGreen),
                      foregroundColor: Color(darkGreen), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: const BorderSide(
                          color: Color(darkGreen),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('logging in');
                        try {
                          FirebaseServices().logOrgIn(
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
                    child: const Text('Log in'),
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
