import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehealth_konoha/base_navigation_widget.dart';
import 'package:ehealth_konoha/components/appointment_card.dart';
import 'package:ehealth_konoha/components/doctor_card.dart';
import 'package:ehealth_konoha/models/doctor_model.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firebaseAuth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    //required this.openProfilePage,
  });
  final int profilePageIndex = 3;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};

  Map<String, dynamic> doctor = {};

  List<dynamic> favList = [];

  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];

  // Function to navigate to ProfilePage
  void _goToProfilePage() {
    BaseNavigationWiget baseNavigationWiget = const BaseNavigationWiget();
    baseNavigationWiget.goToProfilePage(context, widget.profilePageIndex);
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_firebaseAuth.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      var userData = snapshot.data!.data() as Map;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            userData['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _goToProfilePage();
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                userData['image'].toString(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Config.spaceSmall,
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.07,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(
                      medCat.length,
                      (index) {
                        return Card(
                          margin: const EdgeInsets.only(right: 20),
                          color: Config.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                FaIcon(
                                  medCat[index]['icon'],
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  medCat[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Appointment Today',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                const AppointmentCard(),
                Config.spaceSmall,
                const Text(
                  'Top Doctors',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Column(
                //   children: List.generate(5, (index) {
                //     return const DoctorCard(
                //       route: 'doc_details',
                //     );
                //   }),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: DoctorModel.dummyDataDoctor.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DoctorCard(
                      route: 'doc_details',
                      index: index,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
