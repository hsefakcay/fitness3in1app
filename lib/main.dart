import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_ai_app/common/colo_extension.dart';
import 'package:fitness_ai_app/firebase_options.dart';
import 'package:fitness_ai_app/view/main_tab/main_tab_view.dart';
import 'package:fitness_ai_app/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
