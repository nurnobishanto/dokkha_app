import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../helper/global.dart';
import '../controllers/my_packages_controller.dart';

class MyPackagesView extends GetView<MyPackagesController> {
  const MyPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPackagesController controller = Get.put(MyPackagesController());

    return Scaffold(
      appBar: CustomAppBar(title: 'আপনার প্যাকেজ'),
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   automaticallyImplyLeading: true,
      //   title: Text('আপনার প্যাকেজ',
      //     style: AppTextStyles.heading5.copyWith(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primary,
      // ),
      body: !isLoggedIn.value
          ? const AuthGatewayView()
          : Obx(
              () {
                switch (controller.apiCallStatus.value) {
                  case ApiCallStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ApiCallStatus.success:
                    return ListView.builder(
                        itemCount: controller.model.value.packages?.length ?? 0,
                        itemBuilder: (_, index) {
                          final pkg = controller.model.value.packages![index];
                          return PackageCard(
                            name: pkg.package?.name ?? '',
                            startDate: DateTime.parse(pkg.subscribedAt.toString()),
                            endDate: DateTime.parse(pkg.cancelledAt.toString()),
                          );
                        });

                  case ApiCallStatus.error:
                    return const Center(
                        child: Text("ডেটা লোড করতে সমস্যা হয়েছে"));
                  case ApiCallStatus.holding:
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
    );
  }
}

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  final String name;
  final DateTime startDate;
  final DateTime endDate;

  bool get isActive =>
      DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isActive ? "active" : "expired",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "শুরু: ",
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: DateFormatter.formatToDMY(startDate),
                    style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "শেষ: ",
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: DateFormatter.formatToDMY(endDate),
                    style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
