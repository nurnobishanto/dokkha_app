import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerSupportView extends GetView {
  const CustomerSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "কাস্টমার সাপোর্ট",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => makePhoneCall('+8801332804280'),
              child: Image.asset(
                  'assets/images/sample.gif'), // GIF অনুযায়ী path দিন
            ),
            const SizedBox(height: 16),
            const Text(
              "হটলাইন নম্বর",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => makePhoneCall('+8801332804280'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/phone_call.png',
                      width: 25, height: 25),
                  const SizedBox(width: 10),
                  const Text('+8801332804280', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => makePhoneCall('+8809647260543'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/phone_call.png',
                      width: 25, height: 25),
                  const SizedBox(width: 10),
                  const Text('+8809647260543', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/facebook.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text('ফেসবুক পেজ', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                launchUrlString('https://facebook.com/bdtaxationofficial');
              },
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF003277), Color(0xFF002AE8)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    'বার্তা পাঠান',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/whatsapp.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text('অনলাইন সাপোর্ট', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                launchUrlString(
                    'https://api.whatsapp.com/send?phone=8801334260543&text=Hello');
              },
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF00492F), Color(0xFF00A667)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    'অনলাইন সাপোর্টে বার্তা পাঠান',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'কর্পোরেট অফিস',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '৬ষ্ঠ তলা, রাজউক ভবন, ঢাকা', // ঠিকানা বাংলা করে নিন
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ডেভেলপ করেছে:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/company_logo.png', width: 90),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'ভার্সন: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrlString(launchUri.toString());
  }
}
