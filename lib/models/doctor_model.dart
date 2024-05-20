class DoctorModel {
  final String name;
  final String about;
  final String education;
  final String spesialis;
  final String workLocation;
  final String profilePicture;
  final DoctorInfoModel doctorInfoModel;

  DoctorModel({
    required this.name,
    required this.about,
    required this.education,
    required this.spesialis,
    required this.workLocation,
    required this.profilePicture,
    required this.doctorInfoModel,
  });

  static final List<DoctorModel> dummyDataDoctor = [
    DoctorModel(
      name: 'Dr. Sugeng',
      about:
          'Dr. Sugeng is a General Specialist in Sarawak General Hospital. He has 50 years of experience in this field. He has done MBBS from International Medical University, Malaysia and MRCP from Royal College of Physicians, United Kingdom.',
      education:
          'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)',
      spesialis: 'Dental',
      workLocation: 'Sarawak General Hospital',
      profilePicture: 'assets/doctor_2.jpg',
      doctorInfoModel: DoctorInfoModel(
        patients: '100',
        experiences: '50',
        rating: '4.6',
        reviews: '20',
      ),
    )
  ];
}

class DoctorInfoModel {
  final String patients;
  final String experiences;
  final String rating;
  final String reviews;

  DoctorInfoModel({
    required this.patients,
    required this.experiences,
    required this.rating,
    required this.reviews,
  });
}
