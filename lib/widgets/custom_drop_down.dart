import 'package:currency_converter/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final void Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        elevation: 8,
        style: const TextStyle(color: Colors.white),
        dropdownColor: AppColors.mainColor,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>(
          (item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.toUpperCase()),
            );
          },
        ).toList(),
      ),
    );
  }
}
