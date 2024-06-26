import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_ai_app/common/colo_extension.dart';
import 'package:fitness_ai_app/firebase_options.dart';
import 'package:fitness_ai_app/view/login/login_view.dart';
import 'package:fitness_ai_app/view/main_tab/main_tab_view.dart';
import 'package:fitness_ai_app/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../data/repo/user_repository.dart';
import '../data/model/user.dart';
import '../data/UserProvider.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

void checkAuthentication() {
  auth.FirebaseAuth authInstance = auth.FirebaseAuth.instance;
  auth.User? user = authInstance.currentUser;

  if (user != null) {
    // User is signed in.
    print('User is signed in.');
  } else {
    // No user is signed in.
    print('No user is signed in.');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  checkAuthentication();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  //isFirstTime = true; // BU TEST İÇİN VAR KALDIRILACAK!!!!!!!!
  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  MyApp({required this.isFirstTime});

  final bool isFirstTime;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'FitAi Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: TColor.primaryColor1,
            fontFamily: "Poppins"),
        home: isFirstTime ? StartedView() : LoginView(),
      ),
    );
  }
}
