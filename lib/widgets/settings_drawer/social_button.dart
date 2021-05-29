import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends StatelessWidget {
  final String assetPath;
  final String linkHref;

  SocialButton({required this.assetPath, required this.linkHref});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await canLaunch(linkHref)
              ? await launch(linkHref)
              : throw 'Could not launch $linkHref';
        },
        icon: Image.asset(assetPath));
  }
}
