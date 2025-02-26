import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kindred/firebase_options.dart';
import 'package:kindred/screens/select_who_screen.dart';
import 'package:kindred/services/firebase_services.dart';
import 'package:kindred/services/user_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kindred',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),

      home: StreamBuilder(
        stream: FirebaseServices().authStateChange,
        builder: (context, snapshot) {
          // print(snapshot.data!.uid);
          if (snapshot.hasData) {
            return UserTypeProvider(uid: snapshot.data!.uid);
          } else {
            return const SelectWhoScreen();
          }
        },
      ),
    );
  }
}
