import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_register/login.dart';
import 'package:kindred/screens/donor/donor_register/sign_up.dart';
import 'package:kindred/utils/CustomAppBar.dart';

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
        appBar: CustomAppBar(
          title: "Donor",
          tabs: const [
            Tab(text: "Log-in"),
            Tab(text: "Sign-up"),
          ],
        ),
        backgroundColor: Colors.white,
        body: const TabBarView(
          children: [
            LoginDonor(),
            SignUpDonor(),
          ],
        ),
      ),
    );
  }
}
