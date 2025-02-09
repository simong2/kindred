import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

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

    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 1.3,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email,
                      color: Color(0xFF667B68)), // Changed icon color
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: Color(0xFF667B68)), // Changed label text color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF667B68)), // Default border color
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
                obscureText: showPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock,
                      color: Color(0xFF667B68)), // Lock icon color
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Color(0xFF667B68), // Eye icon color
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle:
                      const TextStyle(color: Color(0xFF667B68)), // Label text color
                  border: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red), // Default border color
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
                  backgroundColor: Color(0xFFA3B899),
                  foregroundColor: Color(0xFF667B68), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: const BorderSide(
                        color: Colors.red),
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
    );
  }
}
