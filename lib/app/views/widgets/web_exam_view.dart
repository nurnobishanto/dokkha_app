import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/views/views/pdf_viewer.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../routes/app_pages.dart';

class WebExamView extends StatefulWidget {
  final String title;
  final String url;
  final Uint8List? body;

  const WebExamView({
    super.key,
    required this.title,
    required this.url,
    this.body,
  });

  @override
  _WebExamViewState createState() => _WebExamViewState();
}

class _WebExamViewState extends State<WebExamView> {
  late WebViewController _controller;
  bool isLoading = false;
  String currentUrl = '';
  @override
  void initState() {
    super.initState();

    String? token = MySharedPref.getUserToken();

    if (token == '' || token.isEmpty) {
      Get.toNamed(Routes.AUTH_GATEWAY);
    }

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    log("headers : $headers , widget.body ${widget.body} url: ${widget.url}");

    _controller = WebViewController()
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          print("PROGRESS $progress%");
        },
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
            currentUrl = url;
          });
          if (url.contains('packages')) {
            Get.toNamed(Routes.PREMIUM_PACKAGES);
          } else if (url.contains('goback')) {
            Get.back();
          }
        },
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
            currentUrl = url;
          });
          if (url.contains('packages')) {
            _controller.goBack();
          } else if (url.contains('goback')) {
            _controller.goBack();
          }
          print("PROGRESS $url");
        },
        onWebResourceError: (error) {
          setState(() {
            isLoading = false;
          });
        },
      ));
    _controller.loadRequest(
      Uri.parse(widget.url),
      method: LoadRequestMethod.post,
      headers: headers,
      body: widget.body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            //  if exam page
            if (currentUrl.endsWith('start')) {
              bool? shouldExit = await _showCancelExamDialog();
              if (shouldExit != true) {
                return; //  cancel
              }
            }
            if (currentUrl.contains('submit')) {
              Get.back();
            } else if (currentUrl.contains('start')) {
              Get.back();
            } else {
              if (await _controller.canGoBack()) {
                _controller.goBack();
              } else {
                Get.back();
              }
            }
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Container(
                color: Colors.white.withOpacity(0.6),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: currentUrl.contains('pdf')
          ? FloatingActionButton.extended(
              onPressed: () {
                launchUrlString(currentUrl);
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                'ডাউনলোড',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              backgroundColor: LightThemeColors.primaryColor,
            )
          : const SizedBox.shrink(),
    );
  }
}

Future<bool?> _showCancelExamDialog() {
  return Get.dialog<bool>(
    AlertDialog(
      title: const Text("Cancel Exam"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "আপনি কি নিশ্চিত যে পরীক্ষা বাতিল করতে চান?\nআপনার অগ্রগতি সংরক্ষিত হবে না।",
            //textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomActionButton(
                  text: 'না',
                  onPressed: () => Get.back(result: false),
                  btnBackgroundColor: Colors.grey,
                  borderColor: Colors.transparent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomActionButton(
                  text: 'হ্যাঁ, বাতিল করুন',
                  onPressed: () => Get.back(result: true),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}
