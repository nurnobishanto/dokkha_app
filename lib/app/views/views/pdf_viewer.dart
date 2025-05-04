import 'package:flutter/material.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key, required this.title, required this.file});
  final String title;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title.toString(),
          style: AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
        ),
        // actions: [
        //   if (isLoggedIn.value) ...[
        //     IconButton(
        //       onPressed: () {
        //         String actualUrl = getActualUrl(file.toString());
        //         debugPrint("Actual URL: $actualUrl");
        //         Share.share(actualUrl);
        //       },
        //       icon: const Icon(Icons.share),
        //     ),
        //     const SizedBox(width: 9),
        //   ],
        // ],
        backgroundColor: LightThemeColors.primaryColor,
        iconTheme: const IconThemeData(
          color: LightThemeColors.white, // Change the back icon color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SfPdfViewer.network(file.toString()),
            ),

          ],
        ),
      ),
    );
  }
}
