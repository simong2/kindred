import 'package:flutter/material.dart';
import 'package:kindred/screens/login.dart';
import 'package:kindred/screens/sign_up.dart';

class DonorEntry extends StatefulWidget {
  const DonorEntry({super.key});

  @override
  State<DonorEntry> createState() => _DonorEntryState();
}

class _DonorEntryState extends State<DonorEntry> {
  @override
  Widget build(BuildContext context) {
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
        body: const TabBarView(
          children: [
            LoginState(),
            SignUp(),
          ],
        ),
      ),
    );
  }
}
