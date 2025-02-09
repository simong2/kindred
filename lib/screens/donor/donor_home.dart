import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_specifc_item.dart';
import 'package:kindred/services/firebase_services.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({Key? key}) : super(key: key);

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF0DDe6d5),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirebaseServices().getPublicOrgItem(), // data stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No requests are open at the moment."));
          } else {
            List<Map<String, dynamic>> orgItems = snapshot.data!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 6 / 7,
              ),
              itemCount: orgItems.length,
              itemBuilder: (BuildContext context, int index) {
                final currItem = orgItems[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonorSpecifcItem(
                          id: currItem['id'],
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 7,
                    margin: const EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              currItem['orgName'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 3,
                              child: Image.asset(currItem['image_path'])),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "Qt: ${currItem['quantity']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
