import 'package:currency_converter/utils/app_constants.dart';
import 'package:flutter/material.dart';

Widget CustomDropdown(
  List<String> items,
  String value,
  void onChanged(val),
) {
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
