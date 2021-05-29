import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool _isLoading = true;

  Widget loadingIndicator = Center(
    child: Column(children: [
      Padding(
          padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0),
          child: Text('Loading help...',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      CircularProgressIndicator(),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help')),
      body: Stack(
          children: [
        WebView(
            initialUrl: 'https://inspiral.nathanfriend.io/help',
            onPageFinished: (finish) {
              setState(() {
                _isLoading = false;
              });
            }),
        _isLoading ? loadingIndicator : null
      ]
              // Remove null entries
              .where((w) => w != null)
              .toList() as List<Widget>),
    );
  }
}
