import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_requests.dart';
import 'package:kindred/screens/donor/profile.dart';
import 'package:kindred/screens/donor/donor_home.dart';
import 'package:kindred/services/firebase_services.dart';

class MainDonorScreen extends StatefulWidget {
  const MainDonorScreen({super.key});

  @override
  State<MainDonorScreen> createState() => _MainDonorScreenState();
}

class _MainDonorScreenState extends State<MainDonorScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DonorHome(),
    DonorRequests(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF0DDe6d5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xF0DDe6d5),
        title: _selectedIndex == 0
            ? const Text("What's Needed?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
            : _selectedIndex == 1
                ? const Text('History')
                : const Text('Kindred'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseServices().signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFA3B899),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF667B68),
        unselectedItemColor: const Color(0xFF667B68),
        onTap: _onItemTapped,
        iconSize: 40,
        selectedFontSize: 1,
        unselectedFontSize: 16,
      ),
    );
  }
}
