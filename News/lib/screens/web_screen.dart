import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';

class WebScreen extends StatefulWidget {
  final _url;
  const WebScreen(this._url);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late WebViewController _controller;
  var isLoading = false;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  _goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }

  _goForward() async {
    if (await _controller.canGoForward()) {
      await _controller.goForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DailyNews',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          IconButton(
            onPressed: _goBack,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          IconButton(
            onPressed: _goForward,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget._url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (web) {
            _controller = web;
          },
        ),
      ),
    );
  }
}
