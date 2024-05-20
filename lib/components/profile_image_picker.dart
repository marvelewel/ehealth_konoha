// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfilePic extends StatefulWidget {
//   const ProfilePic({
//     super.key,
//   });

//   @override
//   State<ProfilePic> createState() => _ProfilePicState();
// }

// class _ProfilePicState extends State<ProfilePic> {
//   File? image;
//   final _currentUser = FirebaseAuth.instance.currentUser;
//   Future getImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? imagePicked =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (imagePicked != null) {
//       image = File(imagePicked.path);
//       setState(() {});
//       try {
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('profile_images')
//             .child("${_currentUser!.uid}.jpg");
//         await storageRef.putFile(image!);
//         final imageURL = await storageRef.getDownloadURL();
//         // await _currentUser.updatePhotoURL(imageURL);
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           CircleAvatar(
//             backgroundImage: image != null
//                 ? FileImage(image!)
//                 : _currentUser!.photoURL != null
//                     ? NetworkImage(_currentUser.photoURL!)
//                     : const AssetImage('assets/images/orang.png')
//                         as ImageProvider,
//           ),
//           Positioned(
//             right: -16,
//             bottom: 0,
//             child: SizedBox(
//                 height: 46,
//                 width: 46,
//                 child: FloatingActionButton(
//                   onPressed: () async {
//                     await getImage();
//                   },
//                   child: const Icon(Icons.camera_alt_outlined),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
