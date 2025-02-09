import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kindred/firebase_options.dart';
import 'package:kindred/services/firebase_services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

void onPressed() {}

class _ProfileState extends State<Profile> {
  late Future<String> _username;

  late Future<String> _email;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    _username = FirebaseServices().getDonorUsername();
    _email = FirebaseServices().getDonorEmail();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xF0DDe6d5),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const ProfileHeading(label: "User Details"),
                    Divider(
                      color: Colors.black,
                      indent: width * 0.05,
                      endIndent: width * 0.05,
                    ),
                    const SizedBox(height: 8),
                    // const UserInfoRow(label: "Username", value: "??"),
                    FutureBuilder(
                        future: _username,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return UserInfoRow(
                                label: "Username", value: snapshot.data!);
                          } else {
                            return const Text("Loading ...");
                          }
                        }),
                    const SizedBox(height: 10),
                    FutureBuilder(
                        future: _email,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return UserInfoRow(
                                label: "Email", value: snapshot.data!);
                          } else {
                            return const Text("Loading ...");
                          }
                        }),

                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                    const ProfileHeading(label: "My Rank"),
                    Divider(
                      color: Colors.black,
                      indent: width * 0.05,
                      endIndent: width * 0.05,
                    ),
                    const SizedBox(height: 10),
                    const UserInfoRow(label: "Rank", value: "??"),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: LinearProgressIndicator(
                        value: 0.5, // Example progress value (70%)
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                        minHeight: 10,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget userInfoRow(label) {
  return Row(
    children: [
      const SizedBox(width: 40),
      Text(
        "$label: ",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(150, 0, 0, 0),
        ),
        textAlign: TextAlign.left,
      ),
    ],
  );
}

class ProfileHeading extends StatelessWidget {
  final String label;

  const ProfileHeading({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 40),
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 40),
        Text(
          "$label: $value",
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(150, 0, 0, 0),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
