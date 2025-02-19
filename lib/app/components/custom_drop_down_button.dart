import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String dropdownValue;
  final void Function(String?)? onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.dropdownValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 17.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withValues(alpha: .3),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(
            color: Colors.black,
          ),
          underline: Container(),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
