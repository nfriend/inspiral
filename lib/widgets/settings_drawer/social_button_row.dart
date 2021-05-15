import 'package:flutter/material.dart';
import 'package:inspiral/widgets/settings_drawer/social_button.dart';

class SocialButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(alignment: WrapAlignment.center, children: [
          SocialButton(
            assetPath: 'images/social_icons/instagram.png',
            linkHref: 'https://www.instagram.com/inspiral.nathanfriend.io/',
          ),
          SocialButton(
            assetPath: 'images/social_icons/facebook.png',
            linkHref: 'https://www.facebook.com/inspiral.nathanfriend.io',
          ),
          SocialButton(
            assetPath: 'images/social_icons/twitter.png',
            linkHref: 'https://twitter.com/inspiral_app',
          ),
          SocialButton(
            assetPath: 'images/social_icons/tumblr.png',
            linkHref: 'https://inspiral-app.tumblr.com/',
          ),
          SocialButton(
            assetPath: 'images/social_icons/gitlab.png',
            linkHref: 'https://gitlab.com/nfriend/inspiral',
          ),
          SocialButton(
            assetPath: 'images/social_icons/email.png',
            linkHref: 'mailto:inspiral@nathanfriend.io',
          )
        ]));
  }
}
