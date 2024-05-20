import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = '';
  String _age = '';
  String _gender = '';
  final List<String> _genders = ['Male', 'Female', 'None'];

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'name': _name,
          'age': _age,
          'gender': _gender,
        });

        Navigator.pop(context);
      } catch (e) {
        print("Error updating profile: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: Config.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: Config.outlinedBorder,
                    focusedBorder: Config.focusBorder,
                    errorBorder: Config.errorBorder,
                  ),
                  onSaved: (value) => _name = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Name cannot be empty' : null,
                ),
                Config.spaceSmall,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: Config.outlinedBorder,
                    focusedBorder: Config.focusBorder,
                    errorBorder: Config.errorBorder,
                  ),
                  onSaved: (value) => _age = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Age cannot be empty' : null,
                ),
                Config.spaceSmall,
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: Config.outlinedBorder,
                    focusedBorder: Config.focusBorder,
                    errorBorder: Config.errorBorder,
                  ),
                  items: _genders.map((String gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value.toString();
                    });
                  },
                  onSaved: (value) => _gender = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Gender cannot be empty' : null,
                ),
                Config.spaceSmall,
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Config.primaryColor,
                  ),
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
