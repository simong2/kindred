import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/main_donor_screen.dart';
import 'package:kindred/screens/org/main_org_screen.dart';
import 'package:kindred/services/firebase_services.dart';

class UserTypeProvider extends StatefulWidget {
  final String uid;
  const UserTypeProvider({required this.uid, super.key});
  @override
  State<UserTypeProvider> createState() => _UserTypeProviderState();
}

class _UserTypeProviderState extends State<UserTypeProvider> {
  late Future<String> _userTypeFuture;

  @override
  void initState() {
    super.initState();
    _userTypeFuture = FirebaseServices().whichUserType(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _userTypeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user type'));
        } else {
          if (snapshot.data == 'user') {
            return const MainDonorScreen();
          } else {
            return const MainOrgScreen();
          }
        }
      },
    );
  }
}
