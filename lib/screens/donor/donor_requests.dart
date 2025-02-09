import 'package:flutter/material.dart';

class DonorRequests extends StatefulWidget {
  const DonorRequests({Key? key}) : super(key: key);

  @override
  State<DonorRequests> createState() => _DonorRequestsState();
}

class _DonorRequestsState extends State<DonorRequests> {
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