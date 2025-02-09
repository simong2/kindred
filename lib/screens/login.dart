import 'package:flutter/material.dart';
import 'package:kindred/screens/RequestFormsListScreen.dart';
import 'package:kindred/screens/sign_up.dart';

class LoginState extends StatefulWidget {
  const LoginState({super.key});

  @override
  State<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginState> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // Solid color instead of gradient
          centerTitle: true, // Center the title
          title: const Text(
            "CONNECTION", // Uppercase title
            style: TextStyle(
              color: Colors.white, // White color
              fontSize: 20,
              fontWeight: FontWeight.w600, // Semi-bold for a refined look
              letterSpacing: 1.2, // Adds slight spacing for better readability
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left,
                color: Colors.white, size: 32), // Chevron icon in white
            onPressed: () {
              Navigator.pop(context); // Go back when pressed
            },
          ),

          bottom: const TabBar(
            labelColor: Colors.white, // White text color for selected tab
            unselectedLabelColor:
                Colors.white70, // Dimmed white for unselected tabs
            indicatorColor: Colors.white, // White underline indicator
            tabs: [
              Tab(
                child: Text(
                  'LOG-IN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2, // Improves readability
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'SIGN-UP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      child: Center(
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
                            const SizedBox(height: 40),
                            SizedBox(
                              width: width / 2,
                              height: height * .06,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RequestFormsListScreen()));
                                },
                                child: const Text('Log in'),
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
            const SignUp(),
          ],
        ),
      ),
    );
  }
}
