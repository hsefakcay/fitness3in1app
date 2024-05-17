import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_ai_app/common/colo_extension.dart';
import 'package:fitness_ai_app/firebase_options.dart';
import 'package:fitness_ai_app/view/main_tab/main_tab_view.dart';
import 'package:fitness_ai_app/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repo/user_repository.dart';
import '../data/model/user.dart';

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

void signInWithEmailAndPassword(String email, String password) async {
  try {
    auth.UserCredential userCredential =
        await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    auth.User? user = userCredential.user;
    print('User signed in: ${user?.email}');
  } catch (e) {
    print('Failed to sign in: $e');
  }
}

Future<void> main() async {
  signInWithEmailAndPassword('buraya mail', "buraya şifreni yaz");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  UserRepository userRepository = UserRepository();
  // Example usage
  User newUser = User(
    id: '1234',
    name: 'John',
    surname: 'Doe',
    mail: 'john.doe@example.com',
    password: 'password123',
    age: 25,
    gender: 'Male',
    height: 180.0,
    weight: 75.0,
    programType: 'Fitness',
  );

  // Add user
  await userRepository.addUser(newUser);

  checkAuthentication();
  // Get user
  User? fetchedUser = await userRepository.getUserById('123');
  print('Fetched user: ${fetchedUser?.name}');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  MyApp({required this.isFirstTime});
  final bool isFirstTime;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: isFirstTime ? StartedView() : MainTabView(),
    );
  }
}
