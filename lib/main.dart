import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kindred/firebase_options.dart';
import 'package:kindred/screens/HomeScreen.dart';
import 'package:kindred/screens/InternetCheckScreen.dart';
import 'package:kindred/screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Start with the splash screen
      routes: {
        '/': (context) =>
            InternetCheckScreen(), // Check internet before proceeding
        '/SplashScreen': (context) => SplashScreen(),
        '/HomeScreen': (context) => HomeScreen(),
      },
    );
  }
}
