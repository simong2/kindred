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
            const Text('Home page') : 
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
          backgroundColor: Color(0xF0A3B899),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              
              icon: Icon(Icons.home, weight: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list, weight: 20),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined, weight: 20),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        )
      );
  }
}
