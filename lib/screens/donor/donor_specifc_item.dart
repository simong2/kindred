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
        backgroundColor: const Color(0xF0DDe6d5),
        title: const Text('Request To Donate'),
      ),
      backgroundColor: const Color(0xF0DDe6d5),
      body: Column(
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
                    Text('${data['orgName']} left a description: '),
                    Text(data['itemDesc']),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Item Picture: '),
                        const SizedBox(width: 20),
                        SizedBox(
                          height: height * .15,
                          child: Image.asset(
                            data['image_path'],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Qt: ${data['quantity']}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * .20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('How much would you like to donate?'),
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
                    SizedBox(
                      height: height * .20,
                    ),
                    ElevatedButton(
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
                            content: Text('Thank you for your contributions!'),
                          ),
                        );
                      },
                      child: const Text('Submit request'),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
