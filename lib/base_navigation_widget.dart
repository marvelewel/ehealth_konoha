import 'package:ehealth_konoha/screens/appointment_page.dart';
import 'package:ehealth_konoha/screens/fav_page.dart';
import 'package:ehealth_konoha/screens/home_page.dart';
import 'package:ehealth_konoha/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BaseNavigationWiget extends StatefulWidget {
  const BaseNavigationWiget({super.key});

  @override
  _BaseNavigationWigetState createState() => _BaseNavigationWigetState();

  void goToProfilePage(BuildContext context, int profilePageIndex) {
    final _BaseNavigationWigetState state =
        context.findAncestorStateOfType<_BaseNavigationWigetState>()!;
    state._goToProfilePage(profilePageIndex);
  }
}

class _BaseNavigationWigetState extends State<BaseNavigationWiget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const FavPage(),
    const AppointmentPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToProfilePage(int profilePageIndex) {
    setState(() {
      _selectedIndex = profilePageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
