import 'package:ehealth_konoha/screens/appointment_page.dart';
import 'package:ehealth_konoha/screens/fav_page.dart';
import 'package:ehealth_konoha/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  //variable declaration
  int currentPage = 0;
  final PageController _page = PageController();
  void changePage(page) {
    setState(() {
      currentPage = page;
      _page.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: const <Widget>[
          //HomePage(openProfilePage: changePage),
          FavPage(),
          AppointmentPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: changePage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidHeart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
