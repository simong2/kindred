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
            return const Center(child: Text("No requests are open at the moment."));
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
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          currItem['orgName'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                           
                          )
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset(currItem['image_path']),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(children: [
                          SizedBox( width: 15),
                          Flexible(
                            child: Text(
                              currItem['itemDesc'], 
                              overflow: TextOverflow.ellipsis, 
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(166, 0, 0, 0)
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
                        // Text(currItem['address'], 
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey
                        //   ),
                        // ),
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
