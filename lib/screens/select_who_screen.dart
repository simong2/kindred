import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_entry.dart';
import 'package:kindred/screens/org/org_entry.dart';
import 'package:kindred/screens/org/org_register/login.dart';

class SelectWhoScreen extends StatefulWidget {
  const SelectWhoScreen({super.key});

  @override
  State<SelectWhoScreen> createState() => _SelectWhoScreenState();
}

class _SelectWhoScreenState extends State<SelectWhoScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: height * .35,
            width: double.infinity,
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'How do you wanna help today?',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                //decoration: const BoxDecoration(
                 // color: Colors.blue,
                 // borderRadius: BorderRadius.vertical(
                  //  top: Radius.circular(30),
                  //),
                //),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonorEntry()),
                            );
                          },
                          child: const Text('Donor'),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: width / 2,
                        height: height * .06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrgEntry()),
                            );
                          },
                          child: const Text('Organization'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
