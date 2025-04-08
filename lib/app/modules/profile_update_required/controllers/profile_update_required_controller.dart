import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUpdateRequiredController extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final occupationController = TextEditingController();
  late  String gender = '';
  late var occupation = '';

  void selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = picked.toIso8601String().split('T').first;
    }
  }

  void submit() {
    print("Name: \${nameController.text}");
    print("DOB: \${dobController.text}");
    print("Gender: \${gender.value}");
    print("Occupation: \${occupationController.text}");
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    occupationController.dispose();
    super.onClose();
  }
}
