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

  late Future<int> _donationsCompleted;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    _username = FirebaseServices().getDonorUsername();
    _email = FirebaseServices().getDonorEmail();
    _donationsCompleted = FirebaseServices().getDonationsCompleted();
  }

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String image_path = "";
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
                    FutureBuilder(
                        future: _donationsCompleted,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            int rank = 0;
                            if (snapshot.data! >= 25) {
                              rank = 4;
                            } else if (snapshot.data! >= 10) {
                              rank = 3;
                            } else if (snapshot.data! >= 5) {
                              rank = 2;
                            } else  if (snapshot.data! >= 2) {
                              rank = 1;
                            }
                            String s = "";
                            switch (rank) {
                              case 0:
                                s = "Apprentice: " + snapshot.data.toString() + "/2 Donations"; 
                                image_path = "assets/img/apprentice.png";
                                break;
                              case 1:
                                s = "Paladin: " + snapshot.data.toString() + "/5 Donations";
                                image_path = "assets/img/paladin.png";
                                break;
                              case 2:
                                s = "Princess: " + snapshot.data.toString() + "/10 Donations";
                                image_path = "assets/img/princess.png";
                                break;
                              case 3:
                                s = "Sorcerer: " + snapshot.data.toString() + "/25 Donations";
                                image_path = "assets/img/sorcerer.png";
                                break;
                              case 4:
                                s = "Grandmaster: You're the best!";
                                image_path = "assets/img/grandmaster.png";
                                break;
                            }
                            return Column( children: [ UserInfoRow(
                                label: "Rank", value: s
                                ), 
                                SizedBox(height: 50),
                                Image.asset(image_path),]);
                          } else {
                            return const Text("Loading ...");
                          }
                        }),
                        
                    
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
