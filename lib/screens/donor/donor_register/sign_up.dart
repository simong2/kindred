import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

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

    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 1.3,
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  fillColor: Colors.white,
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty || value == null
                    ? 'Username is required'
                    : null,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: width / 1.3,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  fillColor: Colors.white,
                  labelText: 'Email',
                  border: OutlineInputBorder(),
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
                obscureText: showPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
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
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty || value == null
                    ? 'Password is required'
                    : null,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: width / 2,
              height: height * .06,
              child: ElevatedButton(
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
                child: const Text('Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
