import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

class DonorSpecifcItem extends StatefulWidget {
  final String id;
  const DonorSpecifcItem({super.key, required this.id});

  @override
  State<DonorSpecifcItem> createState() => _DonorSpecifcItemState();
}

class _DonorSpecifcItemState extends State<DonorSpecifcItem> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _itemFuture;

  // get the values on init
  void _getAllValues() async {
    _itemFuture = FirebaseServices().getSpecifcDonationStuff(widget.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllValues();
  }

  int _selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDe6d5),
        title: const Text('Request To Donate'),
      ),
      backgroundColor: const Color(0xF0DDe6d5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder(
              future: _itemFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading data'),
                  );
                } else {
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.05),
                            Text(
                                '${data['orgName'].toUpperCase()} left a description: '),
                            Text(data['itemDesc']),
                            SizedBox(height: height * 0.05),
                            Image.asset(
                              scale: 1.5,
                              data['image_path'],
                            ),
                            SizedBox(height: height * 0.05),
                            Text(
                              "Qt: ${data['quantity']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Address: ${data['quantity']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * .05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    'How much would you like to donate?'),
                                const SizedBox(width: 10),
                                DropdownButton<int>(
                                  value: _selectedNumber,
                                  onChanged: (int? val) {
                                    setState(() {
                                      _selectedNumber = val!;
                                    });
                                  },
                                  items: List.generate(
                                    data['quantity'],
                                    (index) => DropdownMenuItem<int>(
                                      value: index + 1,
                                      child: Text((index + 1).toString()),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFFA3B899), // Button background color
                                foregroundColor:
                                    const Color(0xFF667B68), // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Color(0xFF667B68),
                                      width: 2), // Border
                                ),
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                FirebaseServices().userSentDonationRequest(
                                  widget.id,
                                  _selectedNumber,
                                  data['image_path'],
                                  data['orgName'],
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Thank you for your contributions!'),
                                  ),
                                );
                              },
                              child: const Text('Submit request'),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
