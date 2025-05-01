import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/core/widgets/base_webview.dart';
import 'package:lokkha/app/modules/premium_packages/controllers/premium_package_checkout_controller.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../../utils/utils.dart';
import '../../../components/custom_action_button.dart';
import '../../../components/custom_text_field.dart';
import '../../../helper/api_helper.dart';
import '../../../helper/global.dart';
import '../models/premium_package_model.dart';

class PremiumPackageCheckoutView
    extends GetView<PremiumPackageCheckoutController> {
  const PremiumPackageCheckoutView({super.key, required this.packagesModel});
  final Package packagesModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PremiumPackageCheckoutController());

    if (kDebugMode) {
      print("Purchase Package build");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "চেকআউট",
          style: AppTextStyles.heading4
              .copyWith(color: LightThemeColors.white, fontSize: 20.0),
        ),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5.0),
                Text(
                  "পূর্ণ নাম",
                  style: AppTextStyles.heading5,
                ),
                const SizedBox(height: 5.0),
                CustomTextField(
                  controller: controller.nameController.value,
                  hintText: 'No update Name',
                  readOnly: true,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "ফোন নম্বর",
                  style: AppTextStyles.heading5,
                ),
                const SizedBox(height: 5.0),
                CustomTextField(
                  controller: TextEditingController(
                    text: profileDataModel.value.data?.name.toString() ?? '',
                  ),
                  hintText: 'No update Phone',
                  readOnly: true,
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Text(
                      'ইমেইল',
                      style: AppTextStyles.heading5,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      "*",
                      style: AppTextStyles.heading5
                          .copyWith(color: Colors.red, fontSize: 20.0),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                CustomTextField(
                  controller: controller.mailController.value,
                  hintText: 'No update Mail',
                ),
                const SizedBox(height: 10.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "অর্ডার",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${packagesModel.name.toString()}\n${convertDaysToHumanReadable(int.parse(packagesModel.duration.toString()))}"),
                            Text(
                              '৳${packagesModel.discountedPrice.toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(),

                        /// coupon
                        // Row(
                        //   children: [
                        //     Text(
                        //       " AppConstant.couponCode.tr",
                        //       style:
                        //           const TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //     Checkbox.adaptive(
                        //       //checkColor: AppColors.primary,
                        //       activeColor: LightThemeColors.primaryColor,
                        //       value: controller.isChecked.value,
                        //       onChanged: (value) {
                        //         controller.isChecked.value = value!;
                        //         controller.updateCoupon();
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // controller.isChecked.value
                        //     ? Column(
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                 flex: 3,
                        //                 child: CustomTextField(
                        //                   controller:
                        //                       controller.couponController,
                        //                   hintText: "AppConstant.couponCode.tr",
                        //                 ),
                        //               ),
                        //               const SizedBox(width: 8),
                        //               Expanded(
                        //                 child: CustomActionButton(
                        //                   text: "AppConstant.apply.tr",
                        //                   onPressed: () {
                        //                     controller.postCoupon(
                        //                         controller
                        //                             .couponController.text,
                        //                         packagesModel.discountedPrice
                        //                             .toString(),
                        //                         context);
                        //                   },
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 10.00),
                        //         ],
                        //       )
                        //     : const SizedBox.shrink(),
                        // const Divider(),
                        const SizedBox(height: 10.00),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "AppConstant.subTotal.tr",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            Text(
                              "৳${packagesModel.discountedPrice.toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ],
                        ),
                        // controller.couponModel.value.status == true
                        //     ? Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const SizedBox(height: 10.00),
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 " AppConstant.discount.tr",
                        //                 style: const TextStyle(
                        //                     color: Colors.red,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontSize: 16.0),
                        //               ),
                        //               Text(
                        //                 "৳${controller.couponModel.value.discount.toString()}",
                        //                 style: const TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                     color: Colors.red,
                        //                     fontSize: 16.0),
                        //               ),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 10.00),
                        //           // Row(
                        //           //   mainAxisAlignment:
                        //           //       MainAxisAlignment.spaceBetween,
                        //           //   children: [
                        //           //     Text(
                        //           //       "AppConstant.total.tr",
                        //           //       style: const TextStyle(
                        //           //           fontWeight: FontWeight.bold,
                        //           //           fontSize: 16.0),
                        //           //     ),
                        //           //     Text(
                        //           //       "৳${controller.couponModel.value.finalAmount.toString()}",
                        //           //       style: const TextStyle(
                        //           //           fontWeight: FontWeight.bold,
                        //           //           fontSize: 16.0),
                        //           //     ),
                        //           //   ],
                        //           // ),
                        //         ],
                        //       )
                        //     : const SizedBox.shrink(),

                        const Divider(),
                        const SizedBox(height: 10.0),
                        const CustomPaymentCardButton(
                            'https://lokkha.com/uploads/files/shares/sadman/bkash.png',
                            0),
                        const SizedBox(height: 10.0),
                        const CustomPaymentCardButton(
                            'https://lokkha.com/uploads/files/shares/sadman/nagad.png',
                            1),
                        const SizedBox(height: 10.0),
                        const CustomPaymentCardButton(
                            'https://lokkha.com/uploads/files/shares/sadman/master_visa_card.png',
                            2),
                        const SizedBox(height: 20.0),

                        //
                        // RichText(
                        //   text: TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text:
                        //             AppConstant.packagesCheckoutDetailsText.tr,
                        //         style: const TextStyle(color: Colors.black),
                        //       ),
                        //       TextSpan(
                        //         text: AppConstant.termsConditions.tr,
                        //         style:
                        //             const TextStyle(color: AppColors.primary),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             Get.to(TermsOfServicesPage());
                        //           },
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.isCheckedCondition.value,
                              onChanged: (value) {
                                controller.isCheckedCondition.value = value!;
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    const TextSpan(
                                        text:
                                            "আমি সম্মত, আমার ডেটা অর্ডার প্রক্রিয়া ও অভিজ্ঞতা উন্নয়নে ব্যবহৃত হতে পারে।"),
                                    TextSpan(
                                      text: "গোপনীয়তা নীতি",
                                      style: const TextStyle(
                                          color: LightThemeColors.primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(
                                            const BaseWebView(
                                              title: 'গোপনীয়তা নীতি',
                                              url: AppConstants.privacyPolicy,
                                            ),
                                          );
                                        },
                                    ),
                                    const TextSpan(text: ', '),
                                    TextSpan(
                                      text: " শর্তাবলী",
                                      style: const TextStyle(
                                          color: LightThemeColors.primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //Get.to(TermsOfServicesPage());
                                        },
                                    ),
                                    const TextSpan(text: ', এবং '),
                                    TextSpan(
                                      text: 'রিফান্ড পলিসি',
                                      style: const TextStyle(
                                          color: LightThemeColors.primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Get.to(RefundPolicyScreen());
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20.0),
                        CustomActionButton(
                          onPressed: () {
                            if (controller.isCheckedCondition.value) {
                              controller.makePayment(
                                  int.parse(packagesModel.id.toString()));
                            } else {
                              CustomSnackBar.showCustomErrorToast(
                                  message: 'চালিয়ে যেতে শর্তাবলী গ্রহণ করুন।');
                            }
                          },
                          text: "পেমেন্ট করুন",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomPaymentCardButton extends StatelessWidget {
  final String assetName;
  final int index;

  const CustomPaymentCardButton(this.assetName, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final paymentSelectionController =
        Get.find<PremiumPackageCheckoutController>();

    return Obx(() {
      return OutlinedButton(
        onPressed: () {
          paymentSelectionController.setSelectedPayment(index);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          side: BorderSide(
              width: (paymentSelectionController.selectedPayment.value == index)
                  ? 2.0
                  : 0.5,
              color: (paymentSelectionController.selectedPayment.value == index)
                  ? Colors.green
                  : Colors.blue.shade600),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.network(
                assetName,
                fit: BoxFit.contain,
                width: 160,
                height: 40,
              ),
            ),
            if (paymentSelectionController.selectedPayment.value == index)
              Positioned(
                  top: 5,
                  bottom: 5,
                  right: 5,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://lokkha.com/uploads/files/shares/sadman/tick-check.png",
                    scale: 13,
                  )

                  // Image.network(
                  //  "https://lokkha.com/uploads/files/shares/sadman/tick-check.png",
                  //   width: 20,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
          ],
        ),
      );
    });
  }
}
