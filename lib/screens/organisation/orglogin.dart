import 'package:flutter/material.dart';
import 'package:kindred/screens/main_org_screen.dart';
import 'package:kindred/screens/orgsign_up.dart';
import 'package:kindred/screens/sign_up.dart';

class OrgLoginState extends StatefulWidget {
  const OrgLoginState({super.key});

  @override
  State<OrgLoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<OrgLoginState> {
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
          backgroundColor: Colors.white,
          title: const Text('Organization'),
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
            // Log-in Tab
            Column(
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
                    onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainOrgScreen()));},
                    child: const Text('Log in'),
                  ),
                ),
              ],
            ),

            // Sign-up Tab
            const OrgSignUp(),
          ],
        ),
      ),
    );
  }
}
