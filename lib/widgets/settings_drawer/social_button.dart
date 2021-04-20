import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SocialButton extends StatelessWidget {
  final String assetPath;
  final String linkHref;
  Future<void> Function() onPressed;

  SocialButton({@required this.assetPath, this.onPressed, this.linkHref}) {
    assert((onPressed == null) ^ (linkHref == null),
        'Exactly one of the `onPressed` and `linkHref` parameters must be non-null');
    if (linkHref != null) {
      onPressed = () async {
        await canLaunch(linkHref)
            ? await launch(linkHref)
            : throw 'Could not launch $linkHref';
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Image.asset(assetPath));
  }
}
