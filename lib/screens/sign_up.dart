import 'package:flutter/material.dart';
import 'package:kindred/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width / 1.3,
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                fillColor: Colors.white,
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: width / 1.3,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
                fillColor: Colors.white,
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: width / 1.3,
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
                fillColor: Colors.white,
                labelText: 'Reenter password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: width / 2,
            height: height * .06,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Sign up'),
            ),
          ),
        ],
      ),
    );
  }
}
