import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class InternetCheckScreen extends StatefulWidget {
  @override
  _InternetCheckScreenState createState() => _InternetCheckScreenState();
}

class _InternetCheckScreenState extends State<InternetCheckScreen> {
  bool isConnected = true; // Assume online initially
  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  /// Check for internet connectivity and listen for changes.
  void checkConnection() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });

    // Listen for connectivity changes
    subscription = Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
              setState(() {
                isConnected = result != ConnectivityResult.none;
              });

              // If internet is back, navigate to SplashScreen
              if (isConnected) {
                Navigator.pushReplacementNamed(context, '/SplashScreen');
              }
            } as void Function(List<ConnectivityResult> event)?)
        as StreamSubscription<ConnectivityResult>?;

    // If already connected at the start, navigate immediately
    if (isConnected) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/SplashScreen');
      });
    }
  }

  @override
  void dispose() {
    subscription?.cancel(); // Cancel stream when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isConnected
            ? CircularProgressIndicator() // Show loading while redirecting
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 80, color: Colors.red),
                  SizedBox(height: 20),
                  Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please check your network and try again.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: checkConnection, // Retry button
                    child: Text("Retry"),
                  ),
                ],
              ),
      ),
    );
  }
}
