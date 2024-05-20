import 'package:ehealth_konoha/base_navigation_widget.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ehealth_konoha/screens/auth_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Lottie.asset("assets/splash.json"),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "ehealth_konoha",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      splashIconSize: 400,
      nextScreen: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BaseNavigationWiget();
          } else {
            return const AuthPage();
          }
        },
      ),
      backgroundColor: Config.primaryColor,
      duration: 1100,
    );
  }
}
