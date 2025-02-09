import 'package:flutter/material.dart';
import 'package:kindred/screens/donor/donor_requests.dart';
import 'package:kindred/screens/donor/profile.dart';
import 'package:kindred/screens/donor/donor_home.dart';
import 'package:kindred/services/firebase_services.dart';

class MainDonorScreen extends StatefulWidget {
  const MainDonorScreen({Key? key}) : super(key: key);

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
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Color(0xF0DDe6d5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xF0DDe6d5),
        title: _selectedIndex == 0 ? 
        const Text("What's Needed?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)) : 
        const Text('Kindred'),
        actions: [
          IconButton(
          onPressed: () {
            FirebaseServices().signOut();
          },
          icon: const Icon(Icons.logout),
          )
        ]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFA3B899),
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFF667B68),
        onTap: _onItemTapped,
        iconSize: 30, // Increase the size of the icons
        selectedFontSize: 20, // Increase the size of the selected label
        unselectedFontSize: 16, // Increase the size of the unselected label
      )
      );
    }
}
