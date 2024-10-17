// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample_oct09/controller/login_screen_controller.dart';
import 'package:firebase_sample_oct09/controller/registration_screen_controller.dart';
import 'package:firebase_sample_oct09/firebase_options.dart';
import 'package:firebase_sample_oct09/view/home_screen/home_screen.dart';
import 'package:firebase_sample_oct09/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationScreenController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
