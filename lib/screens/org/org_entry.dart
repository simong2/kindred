import 'package:flutter/material.dart';
import 'package:kindred/screens/org/org_register/login.dart';
import 'package:kindred/screens/org/org_register/sign_up.dart';

class OrgEntry extends StatefulWidget {
  const OrgEntry({super.key});

  @override
  State<OrgEntry> createState() => _OrgEntryState();
}

class _OrgEntryState extends State<OrgEntry> {
  @override
  Widget build(BuildContext context) {
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
        body: const TabBarView(
          children: [
            LoginOrg(),
            OrgSignUp(),
          ],
        ),
      ),
    );
  }
}
