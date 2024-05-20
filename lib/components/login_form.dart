import 'package:ehealth_konoha/components/button.dart';
import 'package:ehealth_konoha/service/firebase_service.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(16.0),
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecurePass = !obsecurePass;
                  });
                },
                icon: obsecurePass
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
          Config.spaceSmall,
          Button(
            width: double.infinity,
            title: 'Sign In',
            onPressed: _loginUser,
            disable: false,
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool result = await _firebaseService!.loginUser(
        email: _emailController.text,
        password: _passController.text,
      );

      if (result) Navigator.popAndPushNamed(context, 'main');
    }
    // try {
    //   await _firebaseAuth.signInWithEmailAndPassword(
    //       email: _emailController.text, password: _passController.text);
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const BaseNavigationWiget()));
    // } on FirebaseAuthException catch (e) {
    //   String message;
    //   if (e.code == 'user-not-found') {
    //     message = 'No user found for that email.';
    //   } else if (e.code == 'wrong-password') {
    //     message = 'Wrong password provided for that user.';
    //   } else {
    //     message = 'Wrong email or password.';
    //   }
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(message),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
  }
}
