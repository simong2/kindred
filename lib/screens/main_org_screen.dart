import 'package:flutter/material.dart';
import 'package:kindred/screens/orgprofile.dart';
import 'package:kindred/screens/profile.dart';

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
      'Index 1: Requests',
    ),
    OrgProfile(),
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
      )
    );
  }
}