import 'package:flutter/material.dart';
import 'package:kindred/screens/org/orgprofile.dart';
import 'package:kindred/services/firebase_services.dart';

class MainOrgScreen extends StatefulWidget {
  const MainOrgScreen({Key? key}) : super(key: key);

  @override
  State<MainOrgScreen> createState() => _MainOrgScreenState();
}

class _MainOrgScreenState extends State<MainOrgScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Add',
    ),
    Text(
      'Index 1: orgs',
    ),
    OrgProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late Future<String> _orgName;

  void _getOrgName() {
    _orgName = FirebaseServices().getOrgName();
    print('my value changed: $_orgName');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrgName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        title: FutureBuilder(
          future: _orgName,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Kindred');
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            } else {
              var name = snapshot.data!;
              return Text(name);
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseServices().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade200,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
