import 'package:ehealth_konoha/models/doctor_model.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.route,
    required this.index,
  });

  final String route;
  final int index;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: Row(children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: Image.asset(
                    DoctorModel.dummyDataDoctor[index].profilePicture,
                    fit: BoxFit.fill),
              ),
              Flexible(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        DoctorModel.dummyDataDoctor[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DoctorModel.dummyDataDoctor[index].spesialis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(DoctorModel
                              .dummyDataDoctor[index].doctorInfoModel.rating),
                          const Spacer(
                            flex: 1,
                          ),
                          const Text('Reviews'),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(DoctorModel
                              .dummyDataDoctor[index].doctorInfoModel.reviews),
                          const Spacer(
                            flex: 7,
                          )
                        ],
                      ),
                    ]),
              ))
            ])),
        onTap: () {
          //redirect to doctor details
          Navigator.of(context).pushNamed(
            route,
            arguments: DoctorModel.dummyDataDoctor[index],
          );
        },
      ),
    );
  }
}
