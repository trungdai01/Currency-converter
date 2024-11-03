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
      width: 120,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: widget.value,
          isExpanded: true,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 14.0),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            width: 120,
            offset: const Offset(0, -5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            elevation: 2,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
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
                  style: const TextStyle(
                    fontSize: 18,
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

// class CustomDropdown extends StatefulWidget {
//   final List<String> items;
//   final String value;
//   final void Function(String?)? onChanged;
//   const CustomDropdown({
//     super.key,
//     required this.items,
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2,
//       child: DropdownButtonHideUnderline(
//         child: GFDropdown(
//           isDense: true,
//           value: widget.value,
//           items: widget.items.map<DropdownMenuItem<String>>(
//             (item) {
//               return DropdownMenuItem(
//                 value: item,
//                 child: Text(item.toUpperCase()),
//               );
//             },
//           ).toList(),
//           onChanged: widget.onChanged,
//         ),
//       ),
//     );
//   }
// }
