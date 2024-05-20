import 'package:ehealth_konoha/components/doctor_card.dart';
import 'package:ehealth_konoha/models/doctor_model.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'My Favorite Doctors',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: DoctorModel.dummyDataDoctor.length,
                itemBuilder: (BuildContext context, int index) {
                  return DoctorCard(
                    route: 'doc_details',
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
