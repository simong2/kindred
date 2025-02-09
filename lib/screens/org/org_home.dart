import 'package:flutter/material.dart';
import 'package:kindred/screens/org/org_specifc_item.dart';
import 'package:kindred/services/firebase_services.dart';

class OrgHome extends StatefulWidget {
  const OrgHome({super.key});

  @override
  State<OrgHome> createState() => _OrgHomeState();
}

class _OrgHomeState extends State<OrgHome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return StreamBuilder(
      stream: FirebaseServices().getOrgItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else {
          var result = snapshot.data!;
          // print(result);
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: result.length,
            itemBuilder: (context, index) {
              final currItem = result[index];
              // print(currItem);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrgSpecifcItem(
                        id: currItem['id'],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: height / 6,
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child:
                                Image.asset(currItem['image_path'], scale: 2),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 3,
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currItem['itemDesc'],
                                  ),
                                  Text(
                                    'Quantity: ${currItem['quantity'].toString()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
