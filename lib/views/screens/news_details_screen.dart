import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String webViewLink;

  NewsDetailsScreen({this.webViewLink});

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Article Details"), centerTitle: true, backgroundColor: kAccentColor),
      body: WebView(
        initialUrl: widget.webViewLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
