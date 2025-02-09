import 'package:flutter/material.dart';
import 'package:kindred/services/firebase_services.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => _ProfileState();
}

class _ProfileState extends State<OrgProfile> {
  late String _address;
  late String _orgName;
  late String _phoneNumber;
  late String _zipCode;

  Future<void> _getAllInfo() async {
    _address = await FirebaseServices().getOrgInfo('address');
    _orgName = await FirebaseServices().getOrgInfo('orgName');
    _phoneNumber = await FirebaseServices().getOrgInfo('phoneNumber');
    _zipCode = await FirebaseServices().getOrgInfo('zipcode');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: [
        SizedBox(height:15),
        const Row(
          children: [
            SizedBox(width: 8),
            Icon(
              Icons.info_outline,
              size: 25,
            ),
            SizedBox(width: 8),
            Text(
              'About',
              style: TextStyle(fontSize: 20),
            ),
            
          ],
        ),
        SizedBox(height: 16),
        FutureBuilder(
          future: _getAllInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Org\'s data didn\'t load'));
            } else {
              return Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Text(
                        'Organization name:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        _orgName,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        _address,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Text(
                        'Phone number:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        _phoneNumber,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Text(
                        'Zip Code:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        _zipCode,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
