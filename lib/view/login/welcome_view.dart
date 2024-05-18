import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../main_tab/main_tab_view.dart';
import '../../data/model/user.dart';
import '../../data/repo/user_repository.dart';

class WelcomeView extends StatefulWidget {
  final User user; // Define user as a field in the WelcomeView class

  const WelcomeView({Key? key, required this.user})
      : super(key: key); // Add user as a required parameter in the constructor

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final UserRepository userRepository =
      UserRepository(); // Instantiate UserRepository

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Container(
          width: media.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: media.width * 0.1,
              ),
              Image.asset(
                "assets/img/welcome.png",
                width: media.width * 0.75,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Text(
                "Welcome, ${widget.user.name}",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "You are all set now, let’s reach your\ngoals together with us",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.gray, fontSize: 12),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RoundButton(
                    title: "Go To Home",
                    onPressed: () async {
                      await userRepository
                          .addUser(widget.user); // Add user to the database
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainTabView()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
