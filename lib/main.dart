import 'package:camera/camera.dart';
import 'package:chat_app/NewScreen/LandingScreen.dart';
import 'package:chat_app/Screens/CameraScreen.dart';
// import 'package:chat_app/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Colors.teal[900], colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.teal[800]),
          // (0xFF075E54)     (0xFF128C7E)
      ),
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}
