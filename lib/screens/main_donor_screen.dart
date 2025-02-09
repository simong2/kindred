import 'package:flutter/material.dart';
import 'package:kindred/screens/profile.dart';
import 'package:kindred/services/firebase_services.dart';

class MainDonorScreen extends StatefulWidget {
  const MainDonorScreen({Key? key}) : super(key: key);

  @override
  State<MainDonorScreen> createState() => _MainDonorScreenState();
}

class _MainDonorScreenState extends State<MainDonorScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: My Requests',
    ),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade200,
          title: const Text('Kindred'),
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
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'My Requests',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ));
  }
}
