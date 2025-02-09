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

  late Future<String> _rank;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async{
    _username = FirebaseServices().getDonorUsername();
    _email = FirebaseServices().getDonorEmail();
    // _rank = FirebaseServices().getDonorRank()
    _rank = FirebaseServices().getDonorUsername();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        SizedBox(width: 40),
                        Text(
                          "User Details",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
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
                        if (snapshot.connectionState == ConnectionState.done) {
                          return userInfoRow("Username", snapshot.data!);
                        } else {
                          return const Text("Loading ...");
                        }
                      }
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _email, 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return userInfoRow("Email", snapshot.data!);
                        } else {
                          return const Text("Loading ...");
                        }
                      }
                    ),
                   
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                     
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 40),
                        Text(
                          "My Rank",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      indent: width * 0.05,
                      endIndent: width * 0.05,
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: _rank, 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return userInfoRow("Rank", snapshot.data!);
                        } else {
                          return const Text("Loading ...");
                        }
                      }
                    ),
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
          ),
        ],
      ),
    );
  }
}


Widget userInfoRow(label, value) {
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
