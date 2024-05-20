import 'dart:developer';
import 'dart:io';

import 'package:ehealth_konoha/components/button.dart';
import 'package:ehealth_konoha/service/firebase_service.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  FirebaseService? _firebaseService;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  String _password = "";

  File? _image;

  bool obscureText = true;
  bool obsecureConfirmPass = true;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16.0,
                ),
                _profileWidget(),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    if (value.trim() == "") {
                      return 'Please enter valid name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    labelText: 'Email',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.trim().length < 8) {
                      return 'Password minimal 8 karakter';
                    }
                    _password = value;
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Config.primaryColor,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPassController,
                  validator: (value) {
                    if (value != _password) {
                      return 'Confirm password is not correct';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Config.primaryColor,
                  obscureText: obsecureConfirmPass,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecureConfirmPass = !obsecureConfirmPass;
                        });
                      },
                      icon: obsecureConfirmPass
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Button(
                  width: double.infinity,
                  title: 'Sign Up',
                  onPressed: _registerUser,
                  disable: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileWidget() {
    var imageProvider = _image != null
        ? FileImage(_image!)
        : const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: () {
        FilePicker.platform.pickFiles(type: FileType.image).then((result) {
          setState(() {
            _image = File(result!.paths.first!);
          });
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: imageProvider as ImageProvider,
        )),
      ),
    );
  }

  void _registerUser() async {
    log('masuk sini pertama');
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();

      log('masuk sini kedua');

      bool result = await _firebaseService!.registerUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _password,
        photoProfile: _image!,
      );
      log('result => $result');
      if (result) _pop();
    }
  }

  void _pop() {
    Navigator.pop(context);
  }
}
