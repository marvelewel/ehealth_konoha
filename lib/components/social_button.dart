import 'package:ehealth_konoha/utils/config.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.social,
  });

  final String social;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: const BorderSide(width: 1, color: Colors.black),
      ),
      onPressed: () {},
      child: Container(
        // width: Config.widthSize * 0.4,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/$social.png',
              width: 30,
              height: 30,
            ),
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
