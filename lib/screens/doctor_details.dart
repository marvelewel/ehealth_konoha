import 'package:ehealth_konoha/components/button.dart';
import 'package:ehealth_konoha/components/custom_appbar.dart';
import 'package:ehealth_konoha/models/doctor_model.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    super.key,
    required this.doctorModel,
  });

  final DoctorModel doctorModel;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  //for favorite button
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        //for favorite button
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: isFav
                ? const FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.red,
                  )
                : const FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
        AboutDoctor(
          doctorModel: widget.doctorModel,
        ),
        const DetailBody(),
        const Spacer(),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Button(
              width: double.infinity,
              title: 'Book Appointment',
              onPressed: () {
                Navigator.of(context).pushNamed('booking_page');
              },
              disable: false,
            ))
      ])),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage(
              "assets/doctor_2.jpg",
            ),
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            doctorModel.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Sarawak General Hospital',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            DoctorInfo(),
            Config.spaceSmall,
            Text(
              'About Doctor',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              'Dr. Sugeng is a General Specialist in Sarawak General Hospital. He has 50 years of experience in this field. He has done MBBS from International Medical University, Malaysia and MRCP from Royal College of Physicians, United Kingdom.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 12,
                height: 1.5,
              ),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ]),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        InfoCard(
          label: 'Patients',
          value: '100',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Experiences',
          value: '50',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Rating',
          value: '4.6',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
