import 'package:flutter/material.dart';
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
      backgroundColor: Color(0xF0DDe6d5),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirebaseServices().getPublicOrgItem(), // data stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No requests available"));
          } else  {

            List<Map<String, dynamic>> orgItems = snapshot.data!;

            return GridView.builder(


              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
              ),
              itemCount: orgItems.length,
              itemBuilder: (BuildContext context, int index) {
                final currItem = orgItems[index];

                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ItemDetails(item: currItem),
                    //   ),
                    // );
                  },
                  borderRadius: BorderRadius.circular(30),

                  child: Card(
                   margin: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // Text(currItem['orgName']),
                        SizedBox(
                          height: 100,
                          child: Image.asset(currItem['image_path']),
                        ),
                        Row(children: [
                          SizedBox( width: 10),
                          Flexible(
                            child: Text(
                              currItem['itemDesc'], 
                              overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ),
                        ],),
                        Text(currItem['quantity'].toString(), 
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          
                        ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      )
  );
  }
}
