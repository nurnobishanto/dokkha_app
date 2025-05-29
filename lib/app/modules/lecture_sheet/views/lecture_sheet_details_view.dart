import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';

class LectureSheetDetailsView extends GetView {
  
  const LectureSheetDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for UI preview
    final name = "Lecture Sheet: Data Structures";
    final description =
        "This sheet covers basic to advanced concepts of data structures, including arrays, linked lists, trees, and graphs.";
    final lecturesheetsCount = 5;
    final fileUrl = "https://example.com/file.pdf"; // Assume it's a PDF
    final isPdf = fileUrl.endsWith('.pdf');

    return Scaffold(
      appBar: CustomAppBar(title: "Sheet Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name
            Text(
              name,
              style: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            /// Description
            Text(
              description,
              style: Get.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 16),

            /// Sheet Count
            Row(
              children: [
                const Icon(Icons.insert_drive_file_rounded, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Total Sheets: $lecturesheetsCount",
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// File Display (Image or PDF Icon)
            Text(
              "Attached File",
              style: Get.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isPdf
                  ? Container(
                      color: Colors.grey.shade200,
                      height: 150,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.picture_as_pdf,
                                size: 48, color: Colors.red),
                            const SizedBox(height: 8),
                            Text("View PDF",
                                style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                    )
                  : Image.network(
                      fileUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey.shade200,
                        child: const Center(child: Text("Image not available")),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
