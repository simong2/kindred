import 'package:flutter/material.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => _ProfileState();
}

class _ProfileState extends State<OrgProfile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return const Center(
      child: Text('org profile screen '),
    );
  }
}
