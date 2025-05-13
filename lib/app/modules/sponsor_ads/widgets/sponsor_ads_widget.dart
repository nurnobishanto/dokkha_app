import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/drawer_pages/views/customer_support_view.dart';
import 'package:lokkha/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/sponsor_ads_model.dart';


class SponsorAdsWidget extends StatelessWidget {
  final Ad ad;
  const SponsorAdsWidget({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(ad.url.toString());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(children: [
          CachedNetworkImage(
            imageUrl: "${AppConstants.storageUrl}${ad.filePath}",
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: 0,
            child: InkWell(
              onTap: (){
                Get.to(const CustomerSupportView());
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                child: const Text(
                  "Sponsored",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

        ]),
      ),
    );
  }
}
