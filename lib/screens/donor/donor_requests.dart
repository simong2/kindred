import 'package:flutter/material.dart';

class DonorRequests extends StatefulWidget {
  const DonorRequests({Key? key}) : super(key: key);

  @override
  State<DonorRequests> createState() => _DonorRequestsState();
}

class _DonorRequestsState extends State<DonorRequests> {
  // Mock stream simulating new donor requests every 2 seconds.
  Stream<List<String>> get donorRequestsStream {
    return Stream.periodic(
      Duration(seconds: 2), 
      (count) => List.generate(count + 1, (index) => 'Item $index'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF0DDe6d5),
      body: StreamBuilder<List<String>>(
        stream: donorRequestsStream, // data stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No requests available"));
          }

          List<String> donorRequests = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Number of columns
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(30.0),
                child: Center(
                  child: Text('Item AHHHHHH $index'),
                ),
              );
            },
          );
        },
      )
    );
  }
}