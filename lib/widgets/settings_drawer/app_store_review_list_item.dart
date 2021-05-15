import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:inspiral/environment_config.dart';

class AppStoreReviewListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _inAppReview = InAppReview.instance;

    Widget appStoreReviewListItem = Container();

    if (io.Platform.isIOS || io.Platform.isAndroid) {
      var text = Text(io.Platform.isIOS
          ? 'Review on the App Store'
          : 'Review on Google Play');

      appStoreReviewListItem = ListTile(
        title: text,
        onTap: () {
          _inAppReview.openStoreListing(
              appStoreId: EnvironmentConfig.appStoreId);
          Navigator.of(context).pop();
        },
      );
    }

    return appStoreReviewListItem;
  }
}
