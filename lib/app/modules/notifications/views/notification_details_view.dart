import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../views/widgets/image_preview.dart';

class NotificationDetailsPage extends StatelessWidget {
  final String title;
  final String body;
  final String? image;
  final String? webLink;

  const NotificationDetailsPage({
    super.key,
    required this.title,
    required this.body,
    this.webLink,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notifications Details",
          style: TextStyle(
            color: LightThemeColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: LightThemeColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image (Optional)
            if (image != null && image!.isNotEmpty)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    if (webLink!.isNotEmpty && webLink != null) {
                      //conditionalUrlLaunch(webLink!, context);
                      launchUrlString(webLink!);
                    } else {
                      Get.to(ImagePreviewPage(
                          url: AppConstants.storageUrl + image!));
                    }
                  },
                  child: Image.network(
                    AppConstants.storageUrl + image!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade100,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                      height: 1.3,
                    ),
                  ),

                  /// Divider
                  Divider(color: Colors.grey.shade200, thickness: 1),

                  /// Body
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey.shade800,
                      letterSpacing: 0.2,
                    ),
                  ),

                  /// Web Link
                  if (webLink != null && webLink!.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    Material(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () async {
                          launchUrlString(webLink!);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.shade200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.open_in_new_rounded,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Learn More",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "View Full Details",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.blue.shade700,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
