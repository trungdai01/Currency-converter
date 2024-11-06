import 'package:currency_converter/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatefulWidget {
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
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8 * Dimension.width15,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: widget.value,
          isExpanded: true,
          menuItemStyleData: MenuItemStyleData(
            height: Dimension.height40,
            padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 30 * Dimension.height10,
            width: 8 * Dimension.width15,
            offset: Offset(0, -Dimension.height5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimension.radius5),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            elevation: 8,
            height: Dimension.height10 + Dimension.height40,
            padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimension.radius5),
              border: Border.all(color: Colors.black26),
              color: Colors.white,
            ),
          ),
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<String>>(
            (item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item.toUpperCase(),
                  style: TextStyle(
                    fontSize: Dimension.font20,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
