import 'package:flutter/material.dart';
import 'package:kindred/screens/org/add_request_items.dart';
import 'package:kindred/screens/org/org_home.dart';
import 'package:kindred/screens/org/orgprofile.dart';
import 'package:kindred/services/firebase_services.dart';

class MainOrgScreen extends StatefulWidget {
  const MainOrgScreen({super.key});

  @override
  State<MainOrgScreen> createState() => _MainOrgScreenState();
}

class _MainOrgScreenState extends State<MainOrgScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    OrgHome(),
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
    // print('my value changed: $_orgName');
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
      backgroundColor: Color(0xFFDDe6d5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFDDe6d5),
        title: FutureBuilder(
          future: _orgName,
          builder: (context, snapshot) {
            // print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Kindred');
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            } else {
              var name = snapshot.data!;
              return Text(name, style: TextStyle(fontWeight: FontWeight.bold));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF667B68),
        foregroundColor: Color(0xF0DDe6d5),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRequestItems(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFA3B899),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF667B68),
        onTap: _onItemTapped,
        selectedFontSize: 0, // Increase the size of the selected label
        unselectedFontSize: 16, // Increase the size of the unselected label
      ),
    );
  }
}
