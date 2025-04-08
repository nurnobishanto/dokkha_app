import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialLoginWebView extends StatefulWidget {
  const SocialLoginWebView({super.key, required this.url});
  final String url;
  @override
  State<SocialLoginWebView> createState() => _SocialLoginWebViewState();
}

class _SocialLoginWebViewState extends State<SocialLoginWebView> {
  late WebViewController webViewController;
  @override
  void initState() {
    debugPrint("Payment url:${widget.url}");
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Progress Url  :::$progress");
          },
          onPageStarted: (String url) {
            print("onPageStarted Url  :::$url");
          },
          onPageFinished: (String url) {
            print("onPageFinished Url  :::$url");
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print("Request Url  :::${request.url}");
            // if (request.url.contains("google")) {
            //   return NavigationDecision.prevent;
            // }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    if (kDebugMode) {
      print("Load Url make :::${widget.url}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: webViewController)),
    );
  }
}
