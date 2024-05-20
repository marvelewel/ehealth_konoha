import 'package:ehealth_konoha/components/login_form.dart';
import 'package:ehealth_konoha/components/signup_form.dart';
import 'package:ehealth_konoha/components/social_button.dart';
import 'package:ehealth_konoha/utils/config.dart';
import 'package:ehealth_konoha/utils/text.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    //build login text field
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppText.enText['welcome_text']!,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Text(
                  isSignIn
                      ? AppText.enText['signIn_text']!
                      : AppText.enText['register_text']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                isSignIn ? const LoginForm() : const SignUpForm(),
                Config.spaceSmall,
                isSignIn
                    ? Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppText.enText['forgot-password']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                isSignIn ? Config.spaceBig : const SizedBox(),
                Center(
                  child: Text(
                    AppText.enText['social-login']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SocialButton(social: 'google'),
                    SocialButton(social: 'facebook'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      isSignIn
                          ? AppText.enText['signUp_text']!
                          : AppText.enText['registered_text']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isSignIn = !isSignIn;
                        });
                      },
                      child: Text(
                        isSignIn ? 'Sign Up' : 'Sign In',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
