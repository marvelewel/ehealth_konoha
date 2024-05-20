import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehealth_konoha/base_navigation_widget.dart';
import 'package:ehealth_konoha/screens/auth_page.dart';
import 'package:ehealth_konoha/screens/update_profile.dart';
import 'package:ehealth_konoha/service/firebase_service.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  final int profilePageIndex = 2;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  void _goToHistoryPage() {
    BaseNavigationWiget baseNavigationWiget = const BaseNavigationWiget();
    baseNavigationWiget.goToProfilePage(context, widget.profilePageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 70,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        var user = snapshot.data!.data();
                        return CircleAvatar(
                          radius: 65.0,
                          backgroundImage: NetworkImage(
                            user!['image'].toString(),
                          ),
                          backgroundColor: Colors.white,
                        );
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        var user = snapshot.data!.data();
                        return Text(
                          user!['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      var user = snapshot.data!.data();
                      return Text(
                        '${user!['age']} Years Old | ${user['gender']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: 300,
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blueAccent[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateProfilePage()),
                                );
                              },
                              child: const Text(
                                "Profile",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.yellowAccent[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                _goToHistoryPage();
                              },
                              child: const Text(
                                "History",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.lightGreen[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                _firebaseService!.logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AuthPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
