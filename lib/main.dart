import 'package:ehealth_konoha/base_navigation_widget.dart';
import 'package:ehealth_konoha/models/doctor_model.dart';
import 'package:ehealth_konoha/screens/booking_page.dart';
import 'package:ehealth_konoha/screens/doctor_details.dart';
import 'package:ehealth_konoha/screens/profile_page.dart';
import 'package:ehealth_konoha/screens/splash_screen.dart';
import 'package:ehealth_konoha/screens/success_booked.dart';
import 'package:ehealth_konoha/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //define ThemeData here
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        //pre-define input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const SplashScreen());
          case 'main':
            return MaterialPageRoute(
                builder: (context) => const BaseNavigationWiget());
          case 'doc_details':
            final args = settings.arguments as DoctorModel;
            return MaterialPageRoute(
              builder: (context) => DoctorDetails(doctorModel: args),
            );
          case 'booking_page':
            return MaterialPageRoute(builder: (context) => const BookingPage());
          case 'success_booking':
            return MaterialPageRoute(
                builder: (context) => const AppointmentBooked());
          case 'profile_page':
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          default:
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );
        }
      },
    );
  }
}
