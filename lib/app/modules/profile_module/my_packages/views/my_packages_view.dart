import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/config/constants/app_strings.dart';
import '../../../../../utils/date_formatter.dart';
import '../../../../helper/global.dart';
import '../controllers/my_packages_controller.dart';

class MyPackagesView extends GetView<MyPackagesController> {
  const MyPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'আপনার প্যাকেজ'),
      body: Obx(() {
        if (!isLoggedIn.value) {
          return const AuthGatewayView();
        }

        final packages = controller.model.value.packages ?? [];

        if (controller.apiCallStatus.value == ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.apiCallStatus.value == ApiCallStatus.error) {
          return const Center(child: Text("ডেটা লোড করতে সমস্যা হয়েছে"));
        }

        if (packages.isEmpty) {
          return const Center(child: Text(AppStrings.noDataFound));
        }

        if (controller.apiCallStatus.value == ApiCallStatus.success) {
          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (_, index) {
              final pkg = packages[index];
              return PackageCard(
                name: pkg.package?.name ?? '',
                startDate: DateTime.tryParse(pkg.subscribedAt.toString()) ??
                    DateTime.now(),
                endDate: DateTime.tryParse(pkg.cancelledAt.toString()) ??
                    DateTime.now(),
              );
            },
          );
        }

        return const SizedBox.shrink();
      }),
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
                  const TextSpan(
                    text: "শুরু: ",
                    style: TextStyle(
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
                  const TextSpan(
                    text: "শেষ: ",
                    style: TextStyle(
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
