import 'package:flutter/material.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({Key? key}) : super(key: key);

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Number of columns
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(30.0),
            child: Center(
              child: Text('Item $index'),
            ),
          );
        },
      )
    );
  }
}