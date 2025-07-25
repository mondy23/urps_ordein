import 'package:flutter/material.dart';
import 'package:urps_ordein/const/constant.dart';

class MyDropdown extends StatelessWidget {
  final String? value;
  final void Function(String?) onChanged;

  const MyDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final List<String> weeks = const ['Day', 'Week', 'Year'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          hint: const Text("Select a day"),
          value: value,
          items: weeks.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
