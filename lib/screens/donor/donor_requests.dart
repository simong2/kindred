import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

import 'package:intl/intl.dart';

import 'package:kindred/utils/colors.dart';

class DonorRequests extends StatefulWidget {
  const DonorRequests({super.key});

  @override
  State<DonorRequests> createState() => _DonorRequestsState();
}

class _DonorRequestsState extends State<DonorRequests> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return StreamBuilder(
      stream: FirebaseServices().getDonorHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No donations yet 🙃',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          var result = snapshot.data!;

          return ListView.separated(
            itemCount: result.length,
            itemBuilder: (context, index) {
              final currItem = result[index];
              print(currItem);

              return SizedBox(
                height: height / 6,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Image.asset(currItem['image_path']),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Org donated to: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: currItem['orgName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Amount donated : ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: currItem['size'].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Donation date : ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: formatTimeStamp(currItem['timestamp']),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          );
        }
      },
    );
  }
}

String formatTimeStamp(Timestamp ts) {
  DateTime d = ts.toDate();
  String format = DateFormat('MM/dd/yy').format(d);
  return format;
}
