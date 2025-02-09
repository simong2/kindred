import 'package:flutter/material.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Donor'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Log-in'),
              Tab(text: 'Sign-up'),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Column(
              children: [
                // SizedBox(
                //   height: height * .18,
                //   width: double.infinity,
                //   child: Container(
                //     color: Colors.white,
                //     child: const Center(
                //       child: Text(
                //         'Donor Login',
                //         style: TextStyle(
                //           fontSize: 40,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      // decoration: const BoxDecoration(
                      //   color: Colors.blueGrey,
                      //   borderRadius: BorderRadius.vertical(
                      //     top: Radius.circular(30),
                      //   ),
                      // ),
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
                                onPressed: () {},
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
