import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseWebView extends StatefulWidget {
  final String title;
  final String url;

  const BaseWebView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _BaseWebViewState createState() => _BaseWebViewState();
}

class _BaseWebViewState extends State<BaseWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize WebView and enable logging
    // WebViewPlatform.setLoggingEnabled(true);
    _controller = WebViewController();
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
