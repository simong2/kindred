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
        appBar: AppBar(
          backgroundColor: Color(0xFFA3B899),
          foregroundColor: Color(0xFF667B68), // Title and back arrow color
          iconTheme: const IconThemeData(size: 28, color: Color(0xFF667B68)),
          title: const Text('Donor'),
          bottom: const TabBar(
            labelColor: Color(0xFF667B68), // Active tab text color
            unselectedLabelColor: Color(0xFF667B68), // Inactive tab text color
            indicatorColor: Color(0xFF667B68),
            tabs: [
              Tab(text: 'Log-in'),
              Tab(text: 'Sign-up'),
            ],
          ),
        ),
        backgroundColor: Color(0xFFDDE6D5),
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
